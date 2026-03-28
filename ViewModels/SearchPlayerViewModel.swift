import Foundation
import SwiftUI

final class SearchPlayerViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var tempSearchID = String()
    private var searchID = Int()
    
    @Published private(set) var isLoading = false
    @Published private(set) var profile: Profile?
    
    
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
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.profile = result?.profile
                }
            case .failure(let error):
                DispatchQueue.main.async {
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
