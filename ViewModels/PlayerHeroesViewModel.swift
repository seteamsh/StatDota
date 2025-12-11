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
            guard let hero = heroes.first(where: { $0.id == playerHero.heroID } ) else {
                return MergedPlayerHeroes(id: 1, name: "test", imageURL: "test", win: 1, games: 1, lastPlayed: 454, winRate: 50.00)
            }
            return MergedPlayerHeroes(
                id: playerHero.heroID,
                name: hero.localizedName,
                imageURL: hero.name,
                win: playerHero.win,
                games: playerHero.games,
                lastPlayed: playerHero.lastPlayed,
                winRate: Double(playerHero.win) / Double(playerHero.games) * 100.00
            )
        }
    }
}
