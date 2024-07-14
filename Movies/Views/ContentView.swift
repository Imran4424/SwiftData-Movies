//
//  ContentView.swift
//  Movies
//
//  Created by Shah Md Imran Hossain on 26/5/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isAddMoviePresented = false
    
    var body: some View {
        NavigationStack {
            VStack {
                MovieListView()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isAddMoviePresented.toggle()
                    } label: {
                        Text("Add")
                    }
                }
            }
            .fullScreenCover(isPresented: $isAddMoviePresented) {
                NavigationStack {
                    AddMovieView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
