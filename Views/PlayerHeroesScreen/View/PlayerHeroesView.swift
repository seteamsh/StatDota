import SwiftUI

struct PlayerHeroesView: View {
    
    var vm: PlayerHeroesViewModel
    
    var body: some View {
        PlayerHeroesDescriptionCard()
        
        VStack(spacing: 5) {
            ForEach(vm.playerHeroes, id: \.id) { hero in
                PlayerHeroCard(vm: PlayerHeroCardViewModel(hero: hero))
            }
        }
    }
}
#Preview {
    PlayerHeroesView(
        vm: PlayerHeroesViewModel(
            playerHeroes: [MergedPlayerHeroes(
                id: 1,
                name: "343",
                imageURL: "fd",
                win: 1,
                games: 1,
                lastPlayed: 1,
                winRate: 1.1
            )]
        )
    )
}
