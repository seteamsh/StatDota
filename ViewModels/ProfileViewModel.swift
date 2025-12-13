import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var win: Int?
    @Published var lose: Int?
    @Published var winRate: Double?
    @Published var errorMessage: String?
    
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
                    self.errorMessage = handleError(error: error)
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
}
