import SwiftUI

struct PlayerHeroesView: View {
    @StateObject var vm = PlayerHeroesViewModel()
    @Binding var isTurbo: Bool
    var profile: Profile
    var body: some View {
        VStack {
            ForEach(vm.mergedPlayerHeroes, id: \.id) { hero in
                PlayerHeroCard(hero: hero)
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

