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
    @State private var isshowReviewPresented: Bool = false
    
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
            
            Section("Reviews") {
                Button {
                    isshowReviewPresented = true
                } label: {
                    Image(systemName: "plus")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                if movie.reviews.isEmpty {
                    ContentUnavailableView {
                        Text("No reviews yet")
                    }
                } else {
                    ReviewListView(movie: movie)
                }
            }
            
            Section("Actors") {
                if movie.actors.isEmpty {
                    ContentUnavailableView {
                        Text("No actors information available")
                    }
                } else {
                    List(movie.actors) { actor in
                        ActorCellView(actor: actor)
                    }
                }
            }
        }
        .onAppear {
            title = movie.title
            year = movie.year
        }
        .fullScreenCover(isPresented: $isshowReviewPresented) {
            NavigationStack {
                AddReviewView(movie: movie)
            }
        }
    }
}
