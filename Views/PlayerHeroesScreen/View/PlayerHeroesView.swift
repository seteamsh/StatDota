import SwiftUI

struct PlayerHeroesView: View {
    @StateObject var vm: PlayerHeroesViewModel
    
    var body: some View {
        PlayerHeroesDescriptionCard()
        
        VStack(spacing: 5) {
            ForEach(vm.mergedPlayerHeroes, id: \.id) { hero in
                PlayerHeroCard(hero: hero)
            }
        }
        .onChange(of: vm.playerHeroes) {
            vm.getMergePlayerHeroes(playerHeroes: vm.playerHeroes, heroes: vm.heroes)
        }
        .onAppear {
            vm.getMergePlayerHeroes(playerHeroes: vm.playerHeroes, heroes: vm.heroes)
        }
    }
}
#Preview {
    PlayerHeroesView(
        vm: PlayerHeroesViewModel(
            playerHeroes: [PlayerHeroes(
                heroID: 1,
                lastPlayed: 1,
                games: 1,
                win: 1,
                withGames: 1,
                withWin: 1,
                againstGames: 1,
                againstWin: 1
            )],
            heroes: [Hero](),
            isTurbo: false
        )
    )
}
