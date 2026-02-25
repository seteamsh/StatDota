import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var win: Int?
    @Published var lose: Int?
    @Published var winRate: Double?
    @Published var errorMessage: String?
    @Published var heroes = [Hero]()
    @Published var playerHeroes = [PlayerHeroes]()
    @Published var selectedPage: Pages = .matches
    
    func loadWinLose(id: Int, isTurbo: Bool) {
        let request = APIRequest(resource: WinLoseResource(id: id, isTurbo: isTurbo))
        request.execute { result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.win = result?.win
                    self.lose = result?.lose
                    self.winRate = self.getWinRate(win: result?.win ?? 0, lose: result?.lose ?? 0)
                }
            case .failure(let error):
                print(error)
            }
        }
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
        let request = APIRequest(resource: PlayerHeroesResource(id: id, isTurbo: isTurbo))
        request.execute { result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.playerHeroes = result ?? []
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
    
    enum Pages: String, CaseIterable {
        case matches = "MATCHES"
        case heroes = "HEROES"
    }
}

