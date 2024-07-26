//
//  ActorListView.swift
//  Movies
//
//  Created by Shah Md Imran Hossain on 26/7/24.
//

import SwiftUI

struct ActorListView: View {
    @Environment(\.modelContext) private var context
    
    let actors: [Actor]
    
    var body: some View {
        List {
            ForEach(actors) { actor in
                Text(actor.name)
            }
            .onDelete(perform: deleteActor)
        }
    }
}

extension ActorListView {
    private func deleteActor(indexSet: IndexSet) {
        indexSet.forEach { index in
            let actor = actors[index]
            context.delete(actor)
            
            do {
                try context.save()
            } catch {
                print("error deleting the actor: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    ActorListView(actors: [])
}
