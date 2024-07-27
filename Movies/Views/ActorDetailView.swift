//
//  ActorDetailView.swift
//  Movies
//
//  Created by Shah Md Imran Hossain on 27/7/24.
//

import SwiftData
import SwiftUI

struct ActorDetailView: View {
    @Environment(\.modelContext) private var context
    
    let actor: Actor
    @State private var selectedMovies: Set<Movie> = []
    
    var body: some View {
        VStack {
            MovieSelectionView(selectedMovies: $selectedMovies)
                .onAppear {
                    selectedMovies = Set(actor.movies)
                }
        }
        .onChange(of: selectedMovies) {
            actor.movies = Array(selectedMovies)
            context.insert(actor)
        }
        .navigationTitle(actor.name)
    }
}
