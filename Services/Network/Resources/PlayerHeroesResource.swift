import Foundation

struct PlayerHeroesResource {
    var id: Int
    var isTurbo: Bool
}

extension PlayerHeroesResource: APIResource {
    
    typealias ModelType = [PlayerHeroes]
    
    var methodPath: String {
        "/api/players/\(id)/heroes"
    }
    
    var queryItems: [URLQueryItem]? {
        var items = [URLQueryItem]()
        if isTurbo {
            items.append(URLQueryItem(name: "significant", value: "0"))
            items.append(URLQueryItem(name: "game_mode", value: "23"))
        }
        return items
    }
}
