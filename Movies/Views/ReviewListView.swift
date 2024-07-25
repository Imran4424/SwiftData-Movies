//
//  ReviewListView.swift
//  Movies
//
//  Created by Shah Md Imran Hossain on 25/7/24.
//

import SwiftUI

struct ReviewListView: View {
    let reviews: [Review]
    
    var body: some View {
        List {
            ForEach(reviews) { review in
                VStack(alignment: .leading) {
                    Text(review.subject)
                    Divider()
                    Text(review.bodyDescription)
                }
            }
        }
    }
}

#Preview {
    ReviewListView(reviews: [])
}
