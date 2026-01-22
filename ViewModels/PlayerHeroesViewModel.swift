import Foundation

class PlayerHeroesViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var mergedPlayerHeroes = [MergedPlayerHeroes]()
    
    func getMergePlayerHeroes(playerHeroes: [PlayerHeroes], heroes: [Hero]) {
        mergedPlayerHeroes = playerHeroes.compactMap { playerHero in
            guard let heroes = heroes.first(where: { $0.id == playerHero.heroID }) else { return nil }
            return MergedPlayerHeroes(
                id: playerHero.heroID,
                name: heroes.localizedName,
                imageURL: heroes.name,
                win: playerHero.win,
                games: playerHero.games,
                lastPlayed: playerHero.lastPlayed,
                winRate: playerHero.games == 0 ? 0 : Double(playerHero.win) / Double(playerHero.games) * 100.00)
        }
    }
}
