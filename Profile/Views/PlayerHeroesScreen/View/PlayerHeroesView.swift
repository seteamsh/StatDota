import SwiftUI

struct PlayerHeroesView: View {
    
    var playerHeroes: [MergedPlayerHeroes]
    
    
    var body: some View {
        PlayerHeroesDescriptionCard()
        
        VStack(spacing: 5) {
            ForEach(playerHeroes, id: \.id) { hero in
                PlayerHeroCard(hero: hero)
            }
        }
    }
}
#Preview {
    PlayerHeroesView(
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
}
