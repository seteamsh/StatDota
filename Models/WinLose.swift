struct WinLose: Decodable {
    let win: Int
    let lose: Int
}

enum GameMode {
    case turbo
    case allPick
    
    var mode: String {
        switch self {
        case .turbo: return "?game_mode=23&significant=0"
        case .allPick: return ""
        }
    }
    var findMatches: String {
        switch self {
        case .turbo: return "?game_mode=23&significant=0&limit="
        case .allPick: return "?limit="
        }
        
    }
}
