//
//  AddMovieView.swift
//  Movies
//
//  Created by Shah Md Imran Hossain on 26/5/24.
//

import SwiftUI
import SwiftData

struct AddMovieView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var title: String = ""
    @State private var year: Int?
    
    var isFormValid: Bool {
        if title.isEmptyOrWhiteSpace {
            return false
        }
        
        if year == nil {
            return false
        }
        
        return true
    }
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Year", value: $year, format: .number)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    saveMovie()
                }
                .disabled(!isFormValid)
            }
        }
    }
}

// MARK: - Methods
extension AddMovieView {
    private func saveMovie() {
        guard let year else {
            print("Year is nil")
            return
        }
        
        let movie = Movie(title: title, year: year)
        context.insert(movie)
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
        dismiss()
    }
}

#Preview {
    NavigationStack {
        AddMovieView()
            .modelContainer(for: [Movie.self])
    }
}
