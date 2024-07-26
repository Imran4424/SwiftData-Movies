//
//  MovieListView.swift
//  Movies
//
//  Created by Shah Md Imran Hossain on 14/7/24.
//

import SwiftData
import SwiftUI

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
    
    @State private var isAddMoviePresented: Bool = false
    @State private var isAddActorPresented: Bool = false
    @State private var actorName: String = ""
    
    var body: some View {
        ComposabeListView(movies: movies)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    isAddActorPresented = true
                } label: {
                    Text("Add Actor")
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isAddMoviePresented.toggle()
                } label: {
                    Text("Add Movie")
                }
            }
        }
        .sheet(isPresented: $isAddActorPresented) {
            VStack {
                Text("Add Actor")
                    .font(.largeTitle)
                
                TextField("Actor name", text: $actorName)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                Button {
                    isAddActorPresented = false
                    saveActor()
                } label: {
                    Text("Save")
                }
            }
            .presentationDetents([.medium])
//            .presentationDetents([.fraction(0.25)])
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
        
    }
}

#Preview {
    MovieListView()
}
