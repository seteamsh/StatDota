//
//  PlayerHeroesDescriptionCard.swift
//  StatDota
//
//  Created by Temirlan Zhumashov on 14.12.2025.
//

import SwiftUI

struct PlayerHeroesDescriptionCard: View {
    var body: some View {
        HStack(spacing: 0) {
            Text("Hero")
                .padding(.leading, 5)
            Spacer()
            Text("MP")
                .frame(width: 50, alignment: .leading)
            Text("Win")
                .frame(width: 50, alignment: .leading)
            Text("Win%")
                .frame(width: 45, alignment: .leading)
        }
        .frame(height: 50)
        .border(.gray.opacity(0.5), width: 1)
    }
}

#Preview {
    PlayerHeroesDescriptionCard()
    PlayerHeroCard(hero: MergedPlayerHeroes(id: 1, name: "Invoker", imageURL: "invoker", win: 6800, games: 3000, lastPlayed: 34234, winRate: 100))
}

