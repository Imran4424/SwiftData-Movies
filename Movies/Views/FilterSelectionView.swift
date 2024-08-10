//
//  FilterSelectionVIew.swift
//  Movies
//
//  Created by Shah Md Imran Hossain on 28/7/24.
//

import SwiftUI

enum FilterOption {
    case title(String)
    case reviewsCount(Int)
    case actorsCount(Int)
    case genre(Genre)
    case none
}

struct FilterSelectionView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var filterOption: FilterOption
    @State private var movieTitle: String = ""
    @State private var numberOfReviews: Int = 0
    @State private var numberOfActors: Int = 0
    @State private var selectedGenre: Genre = .action
    
    var body: some View {
        Form {
            Section("Filter by title") {
                TextField("Movie title", text: $movieTitle)
                Button {
                    filterOption = .title(movieTitle)
                    dismiss()
                } label: {
                    Text("Search")
                }
            }
            
            Section("Filter by number of reviews") {
                TextField("number of reviews", value: $numberOfReviews, format: .number)
                    .keyboardType(.numberPad)
                Button {
                    filterOption = .reviewsCount(numberOfReviews)
                    dismiss()
                } label: {
                    Text("Search")
                }
            }
            
            Section("Filter by number of actors") {
                TextField("number of actors", value: $numberOfActors, format: .number)
                    .keyboardType(.numberPad)
                Button {
                    filterOption = .reviewsCount(numberOfActors)
                    dismiss()
                } label: {
                    Text("Search")
                }
            }
            
            Section("Filter by genre") {
                Picker("Select a genre", selection: $selectedGenre) {
                    ForEach(Genre.allCases) { genre in
                        Text(genre.title).tag(genre)
                    }
                }
                .onChange(of: selectedGenre) {
                    filterOption = .genre(selectedGenre)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    FilterSelectionView(filterOption: .constant(.none))
}
