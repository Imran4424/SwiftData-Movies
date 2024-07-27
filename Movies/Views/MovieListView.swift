//
//  MovieListView.swift
//  Movies
//
//  Created by Shah Md Imran Hossain on 14/7/24.
//

import SwiftData
import SwiftUI

enum Sheets: Identifiable {
    case addMovie
    case addActor
    case showFilter
    
    var id: Int {
        return UUID().hashValue
    }
}

struct ComposabeListView: View {
    let movies: [Movie]
    @Environment(\.modelContext) private var context
    
    var body: some View {
        List {
            ForEach(movies) { movie in
                NavigationLink(value: movie) {
                    HStack {
                        Text(movie.title)
                        Spacer()
                        Text(movie.year.description)
                    }
                }
            }
            .onDelete(perform: deleteMovie)
        }
        .navigationDestination(for: Movie.self) { movie in
            MovieDetailView(movie: movie)
        }
    }
}

// MARK: - methods
extension ComposabeListView {
    private func deleteMovie(indexSet: IndexSet) {
        indexSet.forEach { index in
            let movie = movies[index]
            context.delete(movie)
            
            do {
                try context.save()
            } catch {
                print("error deleting the movie: \(error.localizedDescription)")
            }
        }
    }
}

struct MovieListView: View {
    @Environment(\.modelContext) private var context
    
    @Query private var movies: [Movie]
    @Query(sort: \Actor.name, order: .forward) private var actors: [Actor]
    
    @State private var isAddMoviePresented: Bool = false
//    @State private var isAddActorPresented: Bool = false
    @State private var actorName: String = ""
    
    @State private var activeSheet: Sheets?
    
    var body: some View {
        VStack {
            Text("Movies")
                .font(.largeTitle)
            ComposabeListView(movies: movies)
            
            Text("Actors")
                .font(.largeTitle)
            ActorListView(actors: actors)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    activeSheet = .addActor
//                    isAddActorPresented = true
                } label: {
                    Text("Add Actor")
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
//                    activeSheet = .addMovie
                    isAddMoviePresented.toggle()
                } label: {
                    Text("Add Movie")
                }
            }
        }
        .sheet(item: $activeSheet) { activeSheet in
            switch activeSheet {
            case .addMovie:
                EmptyView()
            case .addActor:
                VStack {
                    Text("Add Actor")
                        .font(.largeTitle)
                    
                    TextField("Actor name", text: $actorName)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                    Button {
//                        isAddActorPresented = false
                        saveActor()
                        self.activeSheet = nil
                    } label: {
                        Text("Save")
                    }
                }
                .presentationDetents([.medium])
                //            .presentationDetents([.fraction(0.25)])
            case .showFilter:
                EmptyView()
            }
        }
        .fullScreenCover(isPresented: $isAddMoviePresented) {
            NavigationStack {
                AddMovieView()
            }
        }
    }
}

extension MovieListView {
    private func saveActor() {
        if actorName.isEmpty {
            return
        }
        
        let actor = Actor(name: actorName)
        context.insert(actor)
        
        // for clearing purpose
        actorName = ""
    }
}

#Preview {
    MovieListView()
}
