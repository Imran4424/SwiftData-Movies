//
//  Actor.swift
//  Movies
//
//  Created by Shah Md Imran Hossain on 26/7/24.
//

import SwiftData
import SwiftUI

@Model
final class Actor {
    var name: String
    var movies: [Movie] = []
    
    init(name: String) {
        self.name = name
    }
}
