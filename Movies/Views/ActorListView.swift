//
//  ActorListView.swift
//  Movies
//
//  Created by Shah Md Imran Hossain on 26/7/24.
//

import SwiftUI

struct ActorListView: View {
    let actors: [Actor]
    
    var body: some View {
        List {
            ForEach(actors) { actor in
                Text(actor.name)
            }
        }
    }
}

#Preview {
    ActorListView(actors: [])
}
