//
//  MoviesApp.swift
//  Movies
//
//  Created by Shah Md Imran Hossain on 26/5/24.
//

import SwiftUI

@main
struct MoviesApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
        }
        .modelContainer(for: [Movie.self, Review.self, Actor.self])
    }
}
