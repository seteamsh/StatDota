//
//  PlayerHeroCard.swift
//  StatDota
//
//  Created by Temirlan Zhumashov on 13.12.2025.
//

import SwiftUI

struct PlayerHeroCard: View {
    var hero: MergedPlayerHeroes
    var body: some View {
        HStack(spacing: 10) {
            AsyncImage(
                url: URL(
                    string: "https://cdn.steamstatic.com/apps/dota2/images/dota_react/heroes/\(hero.imageURL.replacingOccurrences(of: "npc_dota_hero_", with: "")).png"
                )
            ) { imgae in
                imgae
                    .resizable()
                    .frame(width: 120, height: 68)
                      
            } placeholder: {
                ZStack {
                    Image(systemName: "person")
                        .font(Font.system(size: 60))
                        .foregroundStyle(.gray)
                        .opacity(0.3)
                    ProgressView()
                }
            }
            VStack(spacing: 0) {
                Text("\(hero.name)")
                Text("\(hero.lastPlayed)")
            }
            Text("\(hero.games)")
            Text("\(hero.win)")
            Text("\(String(format: "%.1f", hero.winRate))")
            
        }
        .border(.gray, width: 1)
    }
}

#Preview {
    PlayerHeroCard(hero: MergedPlayerHeroes(id: 1, name: "Anti-Mage", imageURL: "invoker", win: 68, games: 295, lastPlayed: 34234, winRate: 51.19))
}
