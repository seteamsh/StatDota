import Foundation
import SwiftUI

final class SearchPlayerViewModel: ObservableObject {
    @Published private(set) var isLoading = false
    @Published private(set) var profile: Profile?
    
    @Published var errorMessage: String?
    @Published var tempSearchID = "117124649"
    
    private var searchID = Int()
    
    func setSearchID() throws {
        
        guard !tempSearchID.isEmpty else {
            throw AuthenticationErrors.emptyField
        }
        
        guard let intValue = Int(tempSearchID) else {
            throw AuthenticationErrors.invalidIdFormat
        }
        
        guard !(tempSearchID.count < 7) else {
            throw AuthenticationErrors.playerIdTooShort
        }
        
        guard !(tempSearchID.count > 11) else {
            throw AuthenticationErrors.playerIdTooLong
        }
        
        searchID = intValue
    }
    
    func loadProfile() {
        isLoading = true
        defer {
            isLoading = false
        }
        let request = APIRequest(resource: ProfileResource(id: searchID))
        request.execute { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    self.profile = result?.profile
                    
                case .failure(let error):
                    self.errorMessage = error.errorDescription
                    
                }
            }
            
        }
    }
    
    func searchPlayer() {
        defer {
            profile = nil
            errorMessage = nil
        }
        do {
            try setSearchID()
            loadProfile()
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
