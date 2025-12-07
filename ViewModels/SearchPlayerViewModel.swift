import Foundation
import SwiftUI
class SearchPlayerViewModel: ObservableObject {
    
    @Published var player: Profile?
    @Published var errorMessage = ""
    @Published var searchID: String = "117124649"
    
    func getPlayer(id: Int) {
        NetworkManager.shared.fetchProfile(id: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let player):
                    self.player = player
                    self.errorMessage = ""
                case .failure(let networkError):
                    self.errorMessage = handleError(error: networkError)
                    self.player = nil
                }
            }
        }
    }

    deinit {
        print("SearchPlayerViewModel deinited")
    }
}
