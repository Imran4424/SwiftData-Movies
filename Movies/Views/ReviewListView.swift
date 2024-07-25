//
//  ReviewListView.swift
//  Movies
//
//  Created by Shah Md Imran Hossain on 25/7/24.
//

import SwiftUI

struct ReviewListView: View {
    @Environment(\.modelContext) private var context
    
    let movie: Movie
    
    var body: some View {
        List {
            ForEach(movie.reviews) { review in
                VStack(alignment: .leading) {
                    Text(review.subject)
                    Divider()
                    Text(review.bodyDescription)
                }
            }.onDelete(perform: deleteReview)
        }
    }
}

extension ReviewListView {
    private func deleteReview(indexSet: IndexSet) {
        indexSet.forEach { index in
            let review = movie.reviews[index]
            context.delete(review)
            
            do {
                movie.reviews.remove(at: index)
                try context.save()
            } catch {
                print("error deleting the review: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    ReviewListView(movie: Movie(title: "test", year: 2024))
}
