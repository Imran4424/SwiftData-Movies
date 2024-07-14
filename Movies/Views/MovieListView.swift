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
    
    var body: some View {
        List(movies) { movie in
            Text(movie.title)
        }
    }
}

#Preview {
    MovieListView()
}
