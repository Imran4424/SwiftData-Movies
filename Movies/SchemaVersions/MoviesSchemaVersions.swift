//
//  MoviesSchemaVersions.swift
//  Movies
//
//  Created by Shah Md Imran Hossain on 6/8/24.
//

import Foundation
import SwiftData

enum MoviesSchemaV1: VersionedSchema {
    
    static var versionIdentifier: Schema.Version = Schema.Version(1, 0, 0)
    
    static var models: [any PersistentModel.Type] {
        [Movie.self]
    }
    
    @Model
    final class Movie {
        var title: String
        var year: Int
        
        var reviewsCount: Int {
            return reviews.count
        }
        
        var actorsCount: Int {
            return actors.count
        }
        
        // MARK: - One to many
        @Relationship(deleteRule: .cascade, inverse: \Review.movie)
        var reviews: [Review] = []
        
        @Relationship(deleteRule: .nullify, inverse: \Actor.movies)
        var actors: [Actor] = []
        
        init(title: String, year: Int) {
            self.title = title
            self.year = year
        }
    }
}

enum MoviesSchemaV2: VersionedSchema {
    
    static var versionIdentifier: Schema.Version = Schema.Version(2, 0, 0)
    
    static var models: [any PersistentModel.Type] {
        [Movie.self]
    }
    
    @Model
    final class Movie {
        @Attribute(.unique) var title: String
        var year: Int
        var genreId: Int
        
        var genre: Genre {
            Genre(rawValue: genreId) ?? .action
        }
        
        var reviewsCount: Int {
            return reviews.count
        }
        
        var actorsCount: Int {
            return actors.count
        }
        
        // MARK: - One to many
        @Relationship(deleteRule: .cascade, inverse: \Review.movie)
        var reviews: [Review] = []
        
        @Relationship(deleteRule: .nullify, inverse: \Actor.movies)
        var actors: [Actor] = []
        
        init(title: String, year: Int, genre: Genre) {
            self.title = title
            self.year = year
            self.genreId = genre.id
        }
    }
}
