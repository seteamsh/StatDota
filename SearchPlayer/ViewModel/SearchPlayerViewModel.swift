import Foundation
import SwiftUI

final class SearchPlayerViewModel: ObservableObject {
    @Published private(set) var isLoading = false
    @Published private(set) var profile: Profile?
    
    @Published private(set) var errorMessage: String?
    @Published var searchID = ""
    
    private var request: APIRequest<ProfileResource>
    
    init(profileRequest: APIRequest<ProfileResource>) {
        self.request = profileRequest
    }
    
    func validateSearchID() throws -> Int {
        
        guard !searchID.isEmpty else {
            throw AuthenticationErrors.emptyField
        }
        
        guard searchID.count >= 7 else {
            throw AuthenticationErrors.playerIdTooShort
        }
        
        guard searchID.count <= 11 else {
            throw AuthenticationErrors.playerIdTooLong
        }
        
        guard let intValue = Int(searchID) else {
            throw AuthenticationErrors.invalidIdFormat
        }
        
        return intValue
    }
    
    func loadProfile(id: Int) {
        guard !isLoading else { return }
        isLoading = true
        let resource = ProfileResource(id: id)
        let request = APIRequest(resource: resource)
        self.request = request
        request.execute { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let result):
                    self?.profile = result?.profile
                    
                case .failure(let error):
                    self?.errorMessage = error.errorDescription
                }
            }
        }
    }
    
    func searchPlayer() {
        profile = nil
        errorMessage = nil
        do {
            let id = try validateSearchID()
            loadProfile(id: id)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}


extension SearchPlayerViewModel {
    enum AuthenticationErrors: Error, LocalizedError {
        var minPlayerIDLength: Int {
            7
        }
        var maxPlayerIDLength: Int {
            11
        }
        case emptyField
        case playerIdTooShort
        case playerIdTooLong
        case invalidIdFormat
        
        var errorDescription: String? {
            switch self {
            case .emptyField:
                return "Поле не может быть пустым"
            case .playerIdTooShort:
                return "ID игрока должно быть не менее \(minPlayerIDLength) символов"
            case .playerIdTooLong:
                return "ID игрока должно быть не более \(maxPlayerIDLength) символов"
            case .invalidIdFormat:
                return "ID игрока должен состоять только из цифр"
            }
        }
    }
}
