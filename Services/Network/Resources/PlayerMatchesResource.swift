import Foundation

struct PlayerMatchesResource {
    let id: Int
    var isTurbo: Bool
    var offset: Int
    var limit: Int
}

extension PlayerMatchesResource: APIResource {
    var queryItems: [URLQueryItem]? {
        var items = [
            URLQueryItem(name: "limit", value: "\(self.limit)"),
            URLQueryItem(name: "offset", value: "\(self.offset)")
        ]
        if isTurbo {
            items.append(URLQueryItem(name: "significant", value: "0"))
            items.append(URLQueryItem(name: "game_mode", value: "23"))
        }
        return items
    }
    
    typealias ModelType = [PlayerMatches]
    
    var methodPath: String {
        "/api/players/\(id)/matches"
    }
}

