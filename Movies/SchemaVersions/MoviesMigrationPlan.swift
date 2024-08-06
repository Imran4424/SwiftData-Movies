//
//  MoviesMigrationPlan.swift
//  Movies
//
//  Created by Shah Md Imran Hossain on 6/8/24.
//

import Foundation
import SwiftData

enum MoviesMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [MoviesSchemaV1.self, MoviesSchemaV2.self]
    }
    
    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }
    
    static let migrateV1toV2 = MigrationStage.custom(fromVersion: MoviesSchemaV1.self, toVersion: MoviesSchemaV2.self, willMigrate: { context in
        
        guard let movies = try? context.fetch(FetchDescriptor<Movie>()) else {
            print("[Movie migration] fetching failed")
            return
        }
        
        var duplicates: Set<Movie> = Set<Movie>()
        var uniqueSet: Set<String> = Set<String>()
        
        for movie in movies {
            if !uniqueSet.insert(movie.title).inserted {
                duplicates.insert(movie)
            }
        }
        
        for movie in duplicates {
            guard let movieToBeUpdated = movies.first(where: { $0.id == movie.id }) else {
                continue
            }
            
            movieToBeUpdated.title = movieToBeUpdated.title + " \(UUID().uuidString)"
            
            try? context.save()
        }
        
    }, didMigrate: nil)
}
