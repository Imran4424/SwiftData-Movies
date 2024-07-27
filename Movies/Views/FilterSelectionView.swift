//
//  FilterSelectionVIew.swift
//  Movies
//
//  Created by Shah Md Imran Hossain on 28/7/24.
//

import SwiftUI

enum FilterOption {
    case title(String)
    case none
}

struct FilterSelectionView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var filterOption: FilterOption
    @State private var movieTitle: String = ""
    
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
        }
    }
}

#Preview {
    FilterSelectionView(filterOption: .constant(.none))
}
