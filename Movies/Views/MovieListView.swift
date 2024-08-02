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
    @Query private var movies: [Movie]
    
    let filterOption: FilterOption
    
    init(filterOption: FilterOption) {
        self.filterOption = filterOption
        
        switch self.filterOption {
        case .title(let movieTitle):
            _movies = Query(filter: #Predicate { $0.title.contains(movieTitle) })
        case .reviewsCount(let numberOfReviews):
            _movies = Query(filter: #Predicate { $0.reviews.count >= numberOfReviews })
        case .actorsCount(let numberOfActors):
            _movies = Query(filter: #Predicate { $0.actors.count >= numberOfActors })
        case .none:
            _movies = Query()
        }
    }
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        List {
            ForEach(movies) { movie in
                NavigationLink(value: movie) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(movie.title)
                            Text("Number of Reviews: \(movie.reviewsCount)")
                                .font(.caption)
                            Text("Number of Actors: \(movie.actorsCount)")
                                .font(.caption)
                        }
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
    
//    @Query private var movies: [Movie]
    @Query(sort: \Actor.name, order: .forward) private var actors: [Actor]
    
    @State private var isAddMoviePresented: Bool = false
//    @State private var isAddActorPresented: Bool = false
    @State private var actorName: String = ""
    @State private var activeSheet: Sheets?
    @State private var filterOption: FilterOption = .none
    
    var body: some View {
        VStack {
            HStack {
                Text("Movies")
                    .font(.largeTitle)
                
                Spacer()
                
                Button {
                    activeSheet = .showFilter
                } label: {
                    Text("Filter")
                }

            }
            
            ComposabeListView(filterOption: filterOption)
            
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
                FilterSelectionView(filterOption: $filterOption)
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
