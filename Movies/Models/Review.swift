//
//  Review.swift
//  Movies
//
//  Created by Shah Md Imran Hossain on 14/7/24.
//

import Foundation
import SwiftData

@Model
final class Review {
    var subject: String
    var bodyDescription: String
    var movie: Movie?
    
    init(subject: String, body: String, movie: Movie? = nil) {
        self.subject = subject
        self.bodyDescription = body
        self.movie = movie
    }
}
