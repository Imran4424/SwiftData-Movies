//
//  AddMovieView.swift
//  Movies
//
//  Created by Shah Md Imran Hossain on 26/5/24.
//

import SwiftUI

struct AddMovieView: View {
    @State private var title: String = ""
    @State private var year: Int?
    
    var isFormValid: Bool {
        return title.isEmptyOrWhiteSpace && year != nil
    }
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Year", value: $year, format: .number)
        }
    }
}

#Preview {
    NavigationStack {
        AddMovieView()
    }
}
