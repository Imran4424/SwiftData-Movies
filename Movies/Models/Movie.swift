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
    
    // MARK: - One to many
    @Relationship(deleteRule: .cascade, inverse: \Review.movie)
    var review: [Review] = []
    
    
    init(title: String, year: Int) {
        self.title = title
        self.year = year
    }
}
