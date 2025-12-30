import Kingfisher
import SwiftUI

struct PlayerHeroCard: View {
    var hero: MergedPlayerHeroes
    var body: some View {
        HStack(spacing: 0) {
            KFImage(URL(string: "https://cdn.steamstatic.com/apps/dota2/images/dota_react/heroes/\(hero.imageURL.replacingOccurrences(of: "npc_dota_hero_", with: "")).png"))
                .resizable()
                .frame(width: 88, height: 50)
//            AsyncImage(
//                url: URL(
//                    string: "https://cdn.steamstatic.com/apps/dota2/images/dota_react/heroes/\(hero.imageURL.replacingOccurrences(of: "npc_dota_hero_", with: "")).png"
//                )
//            ) { imgae in
//                imgae
//                    .resizable()
//                    .frame(width: 88, height: 50)
//                      
//            } placeholder: {
//                ZStack {
//                    Rectangle()
//                        .foregroundStyle(.background)
//                        .frame(width: 88, height: 50)
//                    Image(systemName: "person")
//                        .font(Font.system(size: 45))
//                        .foregroundStyle(.gray)
//                        .opacity(0.3)
//                    ProgressView()
//                }
//            }
            .padding(.trailing, 5)
            VStack(alignment: .leading, spacing: 5) {
                Text("\(hero.name)")
                    .font(.system(size: 16))
                Text("\(hero.lastPlayed)")
            }
            Spacer()
                Text("\(hero.games)")
                .frame(width: 50, alignment: .leading)
                    //.border(.white, width: 1)
                Text("\(hero.win)")
                .frame(width: 50, alignment: .leading)
                //.border(.white, width: 1)
                Text("\(String(format: "%.1f", hero.winRate))")
                .frame(width: 45, alignment: .leading)
                //.border(.white, width: 1)
            
            
        }
        
        .frame(maxWidth: .infinity, maxHeight: 50)
        .border(.gray.opacity(0.3), width: 1)
    }
}

#Preview {
    PlayerHeroCard(hero: MergedPlayerHeroes(id: 1, name: "Invoker", imageURL: "invoker", win: 6800, games: 3000, lastPlayed: 34234, winRate: 100))
}
