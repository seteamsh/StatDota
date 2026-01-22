import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var win: Int?
    @Published var lose: Int?
    @Published var winRate: Double?
    @Published var errorMessage: String?
    @Published var heroes = [Hero]()
    @Published var playerHeroes = [PlayerHeroes]()
    @Published var selectedPage: Pages = .matches
    
    private var canLoadMore = true
    
    func loadWinLose(id: Int, isTurbo: Bool) {
        NetworkManager.shared.fetchWinLose(id: id, gameMode: isTurbo ? .turbo : .allPick ) { result in
            switch result {
            case .success(let data):
                DispatchQueue.global(qos: .utility).async {
                    let rate = self.getWinRate(win: data.win, lose: data.lose)
                    DispatchQueue.main.async {
                        self.win = data.win
                        self.lose = data.lose
                        self.winRate = rate
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
            
        }
    }
    
    func getWinRate(win: Int, lose: Int) -> Double {
        guard win + lose > 0 else {
            return 0
        }
        return Double(win) / Double(win + lose) * 100
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
    
    func getPlayerHeroes(id: Int, gameMode: GameMode)  {
        NetworkManager.shared.fetchPlayerHeroes(id: id, gameMode: gameMode) { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let data):
                        self.playerHeroes = data
                    case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    enum Pages: String, CaseIterable {
        case matches = "MATCHES"
        case heroes = "HEROES"
    }
}
