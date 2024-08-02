//
//  Movie.swift
//  Movies
//
//  Created by Shah Md Imran Hossain on 26/5/24.
//

import Foundation
import SwiftData

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
