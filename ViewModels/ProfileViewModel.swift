import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var win = 1
    @Published var lose = 1
    @Published var errorMessage: String?
    func loadWinLose(id: Int, isTurbo: Bool) {
        NetworkManager.shared.fetchWinLose(id: id, gameMode: isTurbo ? .turbo : .allPick ) { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let data):
                        self.win = data.win
                        self.lose = data.lose
                    print("\(self.win)/\(self.lose)")
                    case .failure(let error):
                        self.errorMessage = handleError(error: error)
                }
            }
        }
    }
}
