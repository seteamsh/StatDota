import SwiftUI

struct PlayerHeroesView: View {
    @StateObject var vm = PlayerHeroesViewModel()
    @Binding var isTurbo: Bool
    var profile: Profile
    var body: some View {
        VStack {
            ForEach(vm.mergedPlayerHeroes, id: \.id) { hero in
                HStack {
                    AsyncImage(
                        url: URL(
                            string: "https://cdn.steamstatic.com/apps/dota2/images/dota_react/heroes/\(hero.imageURL.replacingOccurrences(of: "npc_dota_hero_", with: "")).png"
                        )
                    ) { imgae in
                        imgae.resizable()
                            .frame(width: 100, height: 70)
                    } placeholder: {
                        ProgressView()
                    }
                    VStack {
                        Text("\(hero.name)")
                        Text("\(hero.lastPlayed)")
                    }
                    Text("\(hero.games)")
                    Text("\(hero.win)")
                    Text("\(String(format: "%.2f", hero.winRate))")
                    
                }
            }
        }
        .onChange(of: isTurbo) {
            vm.getPlayerHeroes(id: profile.accountId, gameMode: isTurbo ? .turbo : .allPick)
        }
        .onAppear {
            vm.getPlayerHeroes(id: profile.accountId, gameMode: isTurbo ? .turbo : .allPick)
            vm.getHeroes()
        }
    }
}
#Preview {
    PlayerHeroesView(isTurbo: .constant(false), profile: Profile(accountId: 1, personaname: "test", avatar: "fdff", avatarmedium: "fdfdf", avatarfull: "dfdfdf", profileurl: "dfdf", lastLogin: "FDf"))
}

