import Foundation

// MARK: - PlayerHero
struct PlayerHeroes: Codable, Equatable {
    let heroID, lastPlayed, games, win: Int
    let withGames, withWin, againstGames, againstWin: Int

    enum CodingKeys: String, CodingKey {
        case heroID = "hero_id"
        case lastPlayed = "last_played"
        case games, win
        case withGames = "with_games"
        case withWin = "with_win"
        case againstGames = "against_games"
        case againstWin = "against_win"
    }
}

struct MergedPlayerHeroes: Equatable {
    let id: Int
    let name: String
    let imageURL: String
    let win: Int
    let games: Int
    let lastPlayed: Int
    let winRate: Double
}
