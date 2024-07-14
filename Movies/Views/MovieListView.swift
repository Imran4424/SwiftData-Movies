//
//  MovieListView.swift
//  Movies
//
//  Created by Shah Md Imran Hossain on 14/7/24.
//

import SwiftData
import SwiftUI

struct MovieListView: View {
    @Query private var movies: [Movie]
    @State private var isAddMoviePresented = false
    
    var body: some View {
        List(movies) { movie in
            Text(movie.title)
        }
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
