import Foundation

class PlayerHeroesViewModel: ObservableObject {
    
    @Published var errorMessage: String?
    @Published var heroes = [Hero]() {
        didSet {
            getMergePlayerHeroes()
        }
    }
    @Published var playerHeroes = [PlayerHeroes]() {
        didSet {
            getMergePlayerHeroes()
        }
    }
    
    @Published var mergedPlayerHeroes = [MergedPlayerHeroes]()
    
    func getPlayerHeroes(id: Int, gameMode: GameMode)  {
        NetworkManager.shared.fetchPlayerHeroes(id: id, gameMode: gameMode) { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let data):
                        self.playerHeroes = data
                    case .failure(let error):
                        self.errorMessage = handleError(error: error)
                }
            }
        }
    }
    
    func getHeroes() {
        NetworkManager.shared.fetchHeroes { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let heroes):
                    self.heroes = heroes
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func getMergePlayerHeroes() {
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
