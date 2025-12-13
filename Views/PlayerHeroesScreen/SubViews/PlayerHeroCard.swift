
import SwiftUI

struct PlayerHeroCard: View {
    var hero: MergedPlayerHeroes
    var body: some View {
        HStack(spacing: 0) {
            AsyncImage(
                url: URL(
                    string: "https://cdn.steamstatic.com/apps/dota2/images/dota_react/heroes/\(hero.imageURL.replacingOccurrences(of: "npc_dota_hero_", with: "")).png"
                )
            ) { imgae in
                imgae
                    .resizable()
                    .frame(width: 112, height: 63)
                      
            } placeholder: {
                ZStack {
                    Image(systemName: "person")
                        .font(Font.system(size: 60))
                        .foregroundStyle(.gray)
                        .opacity(0.3)
                    ProgressView()
                }
            }
            .padding(.trailing, 10)
            VStack(alignment: .leading, spacing: 5) {
                Text("\(hero.name)")
                Text("\(hero.lastPlayed)")
            }
            Spacer()
            HStack(spacing: 10) {
                Text("\(hero.games)")
                Text("\(hero.win)")
                Text("\(String(format: "%.1f", hero.winRate))")
            }
            .frame(alignment: .leading)
            .padding(.trailing, 1)
            
        }
        
        .frame(maxWidth: .infinity, maxHeight: 68)
        .border(.gray.opacity(0.3), width: 1)
    }
}

#Preview {
    PlayerHeroCard(hero: MergedPlayerHeroes(id: 1, name: "Invoker", imageURL: "invoker", win: 68, games: 3000, lastPlayed: 34234, winRate: 51.19))
}
