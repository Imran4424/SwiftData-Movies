//
//  String+Extensions.swift
//  Movies
//
//  Created by Shah Md Imran Hossain on 26/5/24.
//

import Foundation

extension String {
    var isEmptyOrWhiteSpace: Bool {
        return self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
