import Foundation

struct PlayerMatches {
    let matchID, playerSlot: Int
    let radiantWin: Bool?
    let duration, gameMode, lobbyType, heroID: Int
    let startTime: Int
    let version: Int?
    let kills, deaths, assists: Int
    let averageRank: Int?
    let leaverStatus: Int
    let partySize, heroVariant: Int?
}

extension PlayerMatches: Decodable, Equatable {
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
    //let items: [Item]
}

extension PlayerMatchesProcessed {
    static let dummyData: [PlayerMatchesProcessed] = [
        PlayerMatchesProcessed(
            matchID: 111,
            playerSide: PlayerSide.dire,
            matchResult: GameResult.win,
            duration: "dfdf",
            gameMode: GameMode.turbo,
            lobbyType: 32,
            hero: Hero(id: 1, name: "Invoker", localizedName: "Invoker", primaryAttr: PrimaryAttr.str, attackType: AttackType.ranged, roles: [Role.nuker], legs: 2),
            heroLastPlayed: "34",
            startTime: 32,
            version: 23,
            kills: 23,
            deaths: 23,
            assists: 233,
            averageRank: 4777,
            leaverStatus: 23,
            partySize: 32,
            heroVariant: 3
        )
    ]
}


enum GameResult {
    case win
    case lose
}
enum PlayerSide {
    case radiant
    case dire
}
