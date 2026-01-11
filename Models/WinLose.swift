struct WinLose: Decodable {
    let win: Int
    let lose: Int
}

enum GameMode {
    case turbo
    case allPick
}
