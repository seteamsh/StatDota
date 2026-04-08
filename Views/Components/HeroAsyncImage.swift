import SwiftUI
import Kingfisher

struct HeroAsyncImage: View {
    let heroName: String
    private var herURL: URL? {
        let name = heroName.replacingOccurrences(of: "npc_dota_hero_", with: "")
         return URL(string: "https://cdn.steamstatic.com/apps/dota2/images/dota_react/heroes/\(name).png")
    }
    var body: some View {
        KFImage(herURL)
            .placeholder {
                ZStack {
                    Rectangle()
                        .foregroundStyle(.background)
                        .frame(width: 64, height: 36)
                    Image(systemName: "person")
                        .font(Font.system(size: 45))
                        .foregroundStyle(.gray)
                        .opacity(0.3)
                    ProgressView()
                }
            }
            .resizable()
            .cacheOriginalImage()
            .fade(duration: 0.25)
            .scaledToFill()
            .frame(width: 64, height: 36)
            .clipped()
    }
}

#Preview {
    HeroAsyncImage(heroName: "antimage")
}
