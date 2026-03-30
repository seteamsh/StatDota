import Kingfisher
import SwiftUI

struct PlayerHeroCard: View {
    
    let hero: MergedPlayerHeroes
    
    var body: some View {
        HStack(spacing: 0) {
            HeroAsyncImage(heroName: hero.imageURL)
                .padding(.trailing, 5)
            VStack(alignment: .leading, spacing: 5) {
                Text("\(hero.name)")
                    .font(.system(size: 16))
                Text("\(hero.lastPlayed.timeAgo())")
            }
            Spacer()
            Text("\(hero.games)")
                .frame(width: 50, alignment: .leading)
            Text("\(hero.win)")
                .frame(width: 50, alignment: .leading)
            Text("\(String(format: "%.1f", hero.winRate))")
                .frame(width: 45, alignment: .leading)
        }
        
        .frame(maxWidth: .infinity, maxHeight: 50)
        .border(.gray.opacity(0.3), width: 1)
    }
}

#Preview {
    PlayerHeroCard(
        hero: MergedPlayerHeroes(
            id: 1,
            name: "Invoker",
            imageURL: "invoker",
            win: 6800,
            games: 3000,
            lastPlayed: 34234,
            winRate: 100
        )
    )
}
