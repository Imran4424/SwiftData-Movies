//
//  MovieSelectionView.swift
//  Movies
//
//  Created by Shah Md Imran Hossain on 27/7/24.
//

import SwiftData
import SwiftUI

struct MovieSelectionView: View {
    @Query(sort: \Movie.title, order: .forward) private var movies: [Movie]
    
    @Binding var selectedMovies: Set<Movie>
    
    var body: some View {
        List(movies) { movie in
            HStack {
                Image(systemName: selectedMovies.contains(movie) ? "checkmark.square": "square")
                    .onTapGesture {
                        if !selectedMovies.contains(movie) {
                            selectedMovies.insert(movie)
                        } else {
                            selectedMovies.remove(movie)
                        }
                    }
                Text(movie.title)
            }
        }
    }
}
