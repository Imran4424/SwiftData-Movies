//
//  Genre.swift
//  Movies
//
//  Created by Shah Md Imran Hossain on 10/8/24.
//

import Foundation

enum Genre: Int, Codable, CaseIterable, Identifiable {
    case action = 1
    case horror
    case kids
    case fiction
    
    var id: Int {
        return rawValue
    }
}

extension Genre {
    var title: String {
        switch self {
        case .action:
            return "Action"
        case .horror:
            return "Horror"
        case .kids:
            return "Kids"
        case .fiction:
            return "Fiction"
        }
    }
}
