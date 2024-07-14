//
//  MovieDetailView.swift
//  Movies
//
//  Created by Shah Md Imran Hossain on 14/7/24.
//

import SwiftUI

struct MovieDetailView: View {
    @Environment(\.modelContext) private var context

    let movie: Movie
    @State private var title: String = ""
    @State private var year: Int?
    
    var body: some View {
        VStack {
            Form {
                TextField("Title", text: $title)
                TextField("Year", value: $year, format: .number)
            }
            
            Button("Update") {
                guard let year = year else {
                    return
                }
                
                movie.title = title
                movie.year = year
                
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        .onAppear {
            title = movie.title
            year = movie.year
        }
    }
}