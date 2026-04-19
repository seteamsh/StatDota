import Foundation

final class PlayerHeroesViewModel: ObservableObject {
    
    // MARK: Properties -
    @Published private(set) var playerHeroes = [MergedPlayerHeroes]()
    @Published private(set) var playerHeroesTurbo = [MergedPlayerHeroes]()
    
    private var request: APIRequest<PlayerHeroesResource>?
    private var isLoading = false
    private var profileID: Int
    
    init(profileID: Int) {
        self.profileID = profileID
    }
    // MARK: Methods -
    
    func loadPlayerHeroes(heroes: [Hero], isTurbo: Bool) {
        if !playerHeroes.isEmpty && !playerHeroesTurbo.isEmpty {
            return
        }
        guard !isLoading else { return }
        isLoading = true
        let resource = PlayerHeroesResource(id: profileID, isTurbo: isTurbo)
        let request = APIRequest(resource: resource)
        self.request = request
        
        request.execute { result in
            print("loadPlayerHeroes\(isTurbo)")
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.isLoading = false
                    switch isTurbo {
                    case true:
                        self.playerHeroesTurbo = self.mergPlayerHeroes(heroes: heroes, playerHeroes: result ?? [])
                    case false:
                        self.playerHeroes = self.mergPlayerHeroes(heroes: heroes, playerHeroes: result ?? [])
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func mergPlayerHeroes(heroes: [Hero], playerHeroes: [PlayerHeroes]) -> [MergedPlayerHeroes] {
        return playerHeroes.compactMap { playerHero in
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
