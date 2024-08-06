//
//  MoviesApp.swift
//  Movies
//
//  Created by Shah Md Imran Hossain on 26/5/24.
//

import SwiftData
import SwiftUI

@main
struct MoviesApp: App {
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: Movie.self, migrationPlan: MoviesMigrationPlan.self, configurations: ModelConfiguration(for: Movie.self))
        } catch {
            fatalError("Could not initialize the container")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
        }
        .modelContainer(modelContainer)
    }
}
