import Foundation

struct WinLoseResource {
    var id: Int
    var isTurbo: Bool
}

extension WinLoseResource: APIResource {
    
    typealias ModelType = WinLose
    
    var methodPath: String {
        "/api/players/\(id)/wl"
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
