//
//  AddReviewView.swift
//  Movies
//
//  Created by Shah Md Imran Hossain on 14/7/24.
//

import SwiftData
import SwiftUI

struct AddReviewView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    let movie: Movie
    @State private var subject: String = ""
    @State private var bodyDescription: String = ""
    
    private var isFormValid: Bool {
        return !subject.isEmptyOrWhiteSpace && !bodyDescription.isEmptyOrWhiteSpace
    }
    
    var body: some View {
        VStack {
            Form {
                TextField("Subject", text: $subject)
                TextField("Description", text: $bodyDescription)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Text("Close")
                }

            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    dismiss()
                } label: {
                    Text("Save")
                }
                .disabled(!isFormValid)
            }
        }
        .navigationTitle("Add Review")
        .navigationBarTitleDisplayMode(.inline)
    }
}
