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
    @Query private var movies: [Movie]
    @State private var isAddMoviePresented = false
    
    var body: some View {
        ComposabeListView(movies: movies)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isAddMoviePresented.toggle()
                } label: {
                    Text("Add")
                }
            }
        }
        .fullScreenCover(isPresented: $isAddMoviePresented) {
            NavigationStack {
                AddMovieView()
            }
        }
    }
}

#Preview {
    MovieListView()
}
