//
//  ContentView.swift
//  Movies
//
//  Created by Shah Md Imran Hossain on 26/5/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                MovieListView()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
