import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var win: Int?
    @Published var lose: Int?
    @Published var winRate: Double?
    @Published var errorMessage: String?
    @Published var heroes = [Hero]()
    @Published var playerHeroes = [PlayerHeroes]()
    @Published var selectedPage: Pages = .matches
    
    func loadWinLose(id: Int, isTurbo: Bool) {
        let request = APIRequest(resource: WinLoseResource(id: id, isTurbo: isTurbo))
        request.execute { result in
            DispatchQueue.main.async {
                self.win = result?.win
                self.lose = result?.lose
                self.winRate = self.getWinRate(win: result?.win ?? 0, lose: result?.lose ?? 0)
            }
        }
    }
    
    func loadHeroes() {
        let request = APIRequest(resource: HeroesResource())
        request.execute { result in
            DispatchQueue.main.async {
                self.heroes = result ?? []
            }
        }
    }
    
    func loadPlayerHeroes(id: Int, isTurbo: Bool) {
        let request = APIRequest(resource: PlayerHeroesResource(id: id, isTurbo: isTurbo))
        request.execute { result in
            DispatchQueue.main.async {
                self.playerHeroes = result ?? []
            }
        }
    }
    
    func loadPlayerMatches(id: Int, isTurbo: Bool) {
        
    }
    
    func getWinRate(win: Int, lose: Int) -> Double {
        guard win + lose > 0 else {
            return 0
        }
        return Double(win) / Double(win + lose) * 100
    }
    
    enum Pages: String, CaseIterable {
        case matches = "MATCHES"
        case heroes = "HEROES"
    }
}

class APIRequest<Resource: APIResource> {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}

extension APIRequest: NetworkRequest {
    
    func decode(_ data: Data) -> Resource.ModelType? {
        let decoded = try? JSONDecoder().decode(Resource.ModelType.self, from: data)
        return decoded
    }
    func execute(withCompletion completion: @escaping (ModelType?) -> Void) {
        load(resource.url, withCompletion: completion)
    }
    
}
