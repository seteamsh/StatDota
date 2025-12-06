import Foundation
import SwiftUI
class SearchPlayerViewModel: ObservableObject {
    
    @Published var player: Profile?
    @Published var errorMessage = ""
    @Published var searchID: String = ""
    
    func getPlayer(id: Int) {
        NetworkManager.shared.fetchProfile(id: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let player):
                    self?.player = player
                case .failure(let networkError):
                    self?.errorMessage = self?.handleError(error: networkError) ?? ""
                    self?.player = nil
                }
            }
        }
    }
    
    func handleError(error: NetworkError) -> String {
        switch error {
        case .notFoundPlayerID:
            return "Профиль не найден"
        case .noData:
            return "Нет данных"
        case .decodingError:
            return "Ошибка декодирования"
        }
    }
}
