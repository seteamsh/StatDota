import SwiftUI

struct PlayerHeroesView: View {
    @StateObject var vm = PlayerHeroesViewModel()
    @ObservedObject var profileVM: ProfileViewModel
    @Binding var isTurbo: Bool
    var profile: Profile
    var body: some View {
        PlayerHeroesDescriptionCard()
        VStack(spacing: 5) {
            ForEach(vm.mergedPlayerHeroes, id: \.id) { hero in
                PlayerHeroCard(hero: hero)
            }
        }
        .onChange(of: profileVM.playerHeroes) {
            vm.getMergePlayerHeroes(playerHeroes: profileVM.playerHeroes, heroes: profileVM.heroes)
        }
        .onAppear {
            vm.getMergePlayerHeroes(playerHeroes: profileVM.playerHeroes, heroes: profileVM.heroes)
        }
    }
}
#Preview {
    PlayerHeroesView(profileVM: ProfileViewModel(), isTurbo: .constant(false), profile: Profile(accountId: 1, personaname: "test", avatar: "fdff", avatarmedium: "fdfdf", avatarfull: "dfdfdf", profileurl: "dfdf", lastLogin: "FDf"))
}
