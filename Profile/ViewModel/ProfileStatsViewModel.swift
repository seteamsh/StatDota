import Foundation
final class ProfileStatsViewModel: ObservableObject {
    
    // MARK: Properties-
    @Published private(set) var winRate: Double?
    @Published private(set) var winRateTurbo: Double?
    
    @Published private(set) var winLose: WinLose?
    @Published private(set) var winLoseTurbo: WinLose?
    
    private var request: APIRequest<WinLoseResource>?
    private var isLodading: Bool = false
    
    private var profileID: Int
    
    init(profileID: Int) {
        self.profileID = profileID
    }
    
    //MARK: Methods-
    func loadWinLose(isTurbo: Bool) {
        if winLose != nil && winLoseTurbo != nil { return }
        
        guard !isLodading else { return }
        isLodading = true
        
        let resource = WinLoseResource(id: profileID, isTurbo: isTurbo)
        let request = APIRequest(resource: resource)
        self.request = request
        
        request.execute { result in
            DispatchQueue.main.async {
                self.isLodading = false
                switch result {
                case .success(let result):
                        print("request loadWinLose")
                        switch isTurbo {
                        case true:
                            self.winLoseTurbo = result
                            self.winRateTurbo = self.getWinRate(win: result?.win ?? 0, lose: result?.lose ?? 0)
                        case false:
                            self.winLose = result
                            self.winRate = self.getWinRate(win: result?.win ?? 0, lose: result?.lose ?? 0)
                        }
                    
                case .failure(let error):
                    print(error)
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
