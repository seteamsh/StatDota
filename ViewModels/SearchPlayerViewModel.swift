import Foundation
import SwiftUI

class SearchPlayerViewModel: ObservableObject {
    @Published var errorMessage = ""
    @Published var searchID: String = "117124649"
    @Published private(set) var profile: Profile?
    @Published private(set) var isLoading = false
    
    func loadProfile(id: Int) {
        guard !isLoading else {
            return
        }
        isLoading = true
        let request = APIRequest(resource: ProfileResource(id: id))
        request.execute { result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.profile = result?.profile
                    self.isLoading = false
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    deinit {
        print("SearchPlayerViewModel deinited")
    }
}
