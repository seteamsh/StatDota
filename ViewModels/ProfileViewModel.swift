import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var isTurbo = false
    //MARK: - WinLose Property
    @Published var winLose: WinLose?
    @Published var winLoseTurbo: WinLose?
    
    @Published var winRate: Double?
    @Published var winRateTurbo: Double?
    
    //
    
    @Published var errorMessage: String?
    @Published var heroes = [Hero]()
    @Published var playerHeroes = [PlayerHeroes]()
    @Published var playerHeroesTurbo = [PlayerHeroes]()
    @Published var selectedPage: Pages = .matches
    @Published var mergedPlayerHeroes = [MergedPlayerHeroes]()
    @Published var mergedPlayerHeroesTurbo = [MergedPlayerHeroes]()
    var pages: [Pages] = [.matches, .heroes]
    let profile: Profile
    
    init(profiile: Profile) {
        self.profile = profiile
        loadHeroes()
        loadWinLose()
    }
    
    //MARK: -WinLose Methods
    func loadWinLose() {
        if winLose != nil && winLoseTurbo != nil { return }
        let request = APIRequest(resource: WinLoseResource(id: profile.accountId, isTurbo: isTurbo))
        request.execute { result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    print("request loadWinLose")
                    switch self.isTurbo {
                    case true:
                        self.winLoseTurbo = result
                        self.winRateTurbo = self.getWinRate(win: result?.win ?? 0, lose: result?.lose ?? 0)
                    case false:
                        self.winLose = result
                        self.winRate = self.getWinRate(win: result?.win ?? 0, lose: result?.lose ?? 0)
                    }
                
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getWinRate(win: Int, lose: Int) -> Double {
        guard win + lose > 0 else {
            return 0
        }
        return Double(win) / Double(win + lose) * 100
    }
    
    func loadHeroes() {
        let request = APIRequest(resource: HeroesResource())
        request.execute { result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.heroes = result ?? []
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadPlayerHeroes(id: Int, isTurbo: Bool) {
        if ((!playerHeroes.isEmpty) && (!playerHeroesTurbo.isEmpty)) {
            return
        }
        let request = APIRequest(resource: PlayerHeroesResource(id: id, isTurbo: isTurbo))
        request.execute { result in
            print("loadPlayerHeroes\(isTurbo)")
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    switch isTurbo {
                    case true:
                        self.playerHeroesTurbo = result ?? []
                    case false:
                        self.playerHeroes = result ?? []
                    }
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getMergePlayerHeroes() {
        switch isTurbo {
            case true:
            mergedPlayerHeroesTurbo = mergPlayerHeroes(playerHeroes: playerHeroesTurbo, heroes: heroes)
        case false:
            mergedPlayerHeroes = mergPlayerHeroes(playerHeroes: playerHeroes, heroes: heroes)
        }
        
    }
    
    func mergPlayerHeroes(playerHeroes: [PlayerHeroes], heroes: [Hero]) -> [MergedPlayerHeroes] {
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
    enum Pages: String, CaseIterable {
        
        case matches = "MATCHES"
        case heroes = "HEROES"
    }
}

