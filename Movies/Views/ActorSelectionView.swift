//
//  ActorSelectionView.swift
//  Movies
//
//  Created by Shah Md Imran Hossain on 26/7/24.
//

import SwiftData
import SwiftUI

struct ActorSelectionView: View {
    @Query(sort: \Actor.name, order: .forward) private var actors: [Actor]
    
    @Binding var selectedActors: Set<Actor>
    
    var body: some View {
        List(actors) { actor in
            HStack {
                Image(systemName: selectedActors.contains(actor) ? "checkmark.square": "square")
                    .onTapGesture {
                        if !selectedActors.contains(actor) {
                            selectedActors.insert(actor)
                        } else {
                            selectedActors.remove(actor)
                        }
                    }
                Text(actor.name)
            }
        }
    }
}
