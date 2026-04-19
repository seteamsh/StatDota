import Kingfisher
import SwiftUI

struct PlayerMatchCard: View {
    let match: PlayerMatchesProcessed
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                HeroAsyncImage(heroName: match.hero.name)
                    .padding(.trailing, -3)
                
                VStack(alignment: .leading) {
                        Text(match.hero.localizedName)
                            .font(.system(size: 12, weight: .medium, design: .monospaced))
                    
                    
                    Text("\(match.heroLastPlayed)")
                        .font(.system(size: 12, weight: .medium, design: .monospaced))
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
                .frame(width: 66, alignment: .leading)
                
                Text("\(match.kills)")
                    .frame(width: 45, alignment: .leading)
                
                Text("\(match.deaths)")
                    .frame(width: 45, alignment: .leading)
                
                Text("\(match.assists)")
                    .frame(width: 45, alignment: .leading)
            }
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
            hero: Hero(id: 1, name: "invoker", localizedName: "Outworld Destroyer", primaryAttr: .agi, attackType: .melee, roles: [.carry], legs: 23),
            heroLastPlayed: "9 лет назад",
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
