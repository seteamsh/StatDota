import Foundation

struct PlayerMatches: Codable, Equatable {
    let matchID, playerSlot: Int
    let radiantWin: Bool?
    let duration, gameMode, lobbyType, heroID: Int
    let startTime: Int
    let version: Int?
    let kills, deaths, assists: Int
    let averageRank: Int?
    let leaverStatus: Int
    let partySize, heroVariant: Int?

    enum CodingKeys: String, CodingKey {
        case matchID = "match_id"
        case playerSlot = "player_slot"
        case radiantWin = "radiant_win"
        case duration
        case gameMode = "game_mode"
        case lobbyType = "lobby_type"
        case heroID = "hero_id"
        case startTime = "start_time"
        case version, kills, deaths, assists
        case averageRank = "average_rank"
        case leaverStatus = "leaver_status"
        case partySize = "party_size"
        case heroVariant = "hero_variant"
    }
}

struct PlayerMatchesProcessed: Equatable {
    let matchID: Int
    let playerSide: PlayerSide
    let matchResult: GameResult?
    let duration: String
    let gameMode: GameMode
    let lobbyType: Int
    let hero: Hero
    let heroLastPlayed: String
    let startTime: Int
    let version: Int?
    let kills, deaths, assists: Int
    let averageRank: Int?
    let leaverStatus: Int
    let partySize, heroVariant: Int?
}


enum GameResult {
    case win
    case lose
}
enum PlayerSide {
    case radiant
    case dire
}
