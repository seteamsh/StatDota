import Foundation
import SwiftUI

final class SearchPlayerViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var tempSearchID = String()
    private var searchID = Int()
    
    @Published private(set) var isLoading = false
    @Published private(set) var profile: Profile?
    
    func setSearchID() throws {
        guard let intValue = Int(tempSearchID) else {
            throw AuthenticationErrors.invalidIdFormat
        }
        
        guard !tempSearchID.isEmpty else {
            throw AuthenticationErrors.emptyField
        }
        
        guard !(tempSearchID.count < 6) else {
            throw AuthenticationErrors.playerIdTooShort
        }
        
        guard !(tempSearchID.count > 12) else {
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
                print(error)
            }
        }
    }
    
    func searchPlayer() {
        do {
            try setSearchID()
            loadProfile()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
