//
//  PlayerMatchCard.swift
//  StatDota
//
//  Created by Temirlan Zhumashov on 21.12.2025.
//

import SwiftUI

struct PlayerMatchCard: View {
    var match: PlayerMatchesProcessed
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                AsyncImage(
                    url: URL(
                        string: "https://cdn.steamstatic.com/apps/dota2/images/dota_react/heroes/\(match.hero.name.replacingOccurrences(of: "npc_dota_hero_", with: "")).png"
                    )
                ) { imgae in
                    imgae
                        .resizable()
                        .frame(width: 88, height: 50)
                    
                } placeholder: {
                    ZStack {
                        Rectangle()
                            .foregroundStyle(.background)
                            .frame(width: 88, height: 50)
                        Image(systemName: "person")
                            .font(Font.system(size: 45))
                            .foregroundStyle(.gray)
                            .opacity(0.3)
                        ProgressView()
                    }
                }
                .padding(.trailing, -5)
                VStack(alignment: .leading) {
                    Text("\(match.hero.localizedName)")
                    Text("\(match.heroLastPlayed)")
                }
                .frame(width: 151, alignment: .leading)
                Text("\(match.matchResult ?? .win)")
                    .frame(width: 40, alignment: .leading)
                    
                Text("\(match.gameMode)")
                    .frame(width: 60)
                VStack(alignment: .leading) {
                    Text(match.duration)
                    Text("\(match.playerSide)")
                }
                .frame(width: 60, alignment: .leading)
                Text("\(match.kills)")
                Text("\(match.deaths)")
                Text("\(match.assists)")
            }
            .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
            .border(.gray.opacity(0.3), width: 1)
        }
    }
}

#Preview {
    PlayerMatchCard(
        match: PlayerMatchesProcessed(
            matchID: 11714,
            playerSide: .radiant,
            matchResult: .lose,
            duration: "32141",
            gameMode: .allPick,
            lobbyType: 234,
            hero: Hero(id: 1, name: "invoker", localizedName: "Outworld Destroyer", primaryAttr: .agi, attackType: .melee, roles: [.carry], legs: 23), heroLastPlayed: "9 лет назад",
            startTime: 2341,
            version: 23432,
            kills: 23,
            deaths: 12,
            assists: 32,
            averageRank: 342,
            leaverStatus: 234,
            partySize: 3432,
            heroVariant: 234
        )
    )
}
