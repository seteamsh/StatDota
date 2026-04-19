import SwiftUI

struct PlayerHeroesView: View {
    
    @ObservedObject var vm: PlayerHeroesViewModel
    
    var body: some View {
        PlayerHeroesDescriptionCard()
        
        VStack(spacing: 5) {
            ForEach(vm.playerHeroes, id: \.id) { hero in
                PlayerHeroCard(hero: hero)
            }
        }
    }
}
#Preview {
    PlayerHeroesView(
        vm: PlayerHeroesViewModel(profileID: 117124649)
    )
}
