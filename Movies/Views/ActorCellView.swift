//
//  ActorCellView.swift
//  Movies
//
//  Created by Shah Md Imran Hossain on 27/7/24.
//

import SwiftUI

struct ActorCellView: View {
    let actor: Actor
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(actor.name)
            Text(actor.movies.map { $0.title }, format: .list(type: .and))
                .font(.caption)
        }
    }
}
