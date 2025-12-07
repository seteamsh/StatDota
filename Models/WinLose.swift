struct WinLose: Decodable {
    let win: Int
    let lose: Int
}

enum GameMode {
    case turbo
    case allPick
    
    var mode: String {
        switch self {
        case .turbo: return "&"
        case .allPick: return "?"
        }
    }
}
