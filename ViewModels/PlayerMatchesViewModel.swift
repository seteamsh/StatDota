import Foundation


class PlayerMatchesViewModel: ObservableObject {
    private var matches = [PlayerMatches]() {
        didSet {
            processMatches()
        }
    }
    @Published var processedMatches = [PlayerMatchesProcessed]()
    
    func getPlayerMatches(playerId: Int, gameMode: GameMode) {
        NetworkManager.shared.fetchPlayerMatches(id: playerId, gameMode: gameMode) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let matches):
                    self.matches = matches
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
    func processMatches() {
        processedMatches = matches.map { match in
            return PlayerMatchesProcessed(
                matchID: match.matchID,
                playerSide: getPlayerSide(playerSlot: match.playerSlot),
                matchResult: getGameResult(radiantWin: match.radiantWin, playerSlot: match.playerSlot),
                duration: formatDuration(duration: match.duration),
                gameMode: formatGameMode(gameMode: match.gameMode),
                lobbyType: match.lobbyType,
                heroID: match.heroID,
                startTime: match.startTime,
                version: match.version,
                kills: match.kills,
                deaths: match.deaths,
                assists: match.assists,
                averageRank: match.averageRank,
                leaverStatus: match.leaverStatus,
                partySize: match.partySize,
                heroVariant: match.heroVariant
            )
        }
    }
    func getPlayerSide(playerSlot: Int) -> PlayerSide {
        if playerSlot >= 0 && playerSlot <= 4 {
            return .radiant
        } else {
            return .dire
        }
    }
        
    func getGameResult(radiantWin: Bool?, playerSlot: Int) -> GameResult? {
        let playerSide = getPlayerSide(playerSlot: playerSlot)
        guard radiantWin != nil else {
            return nil
        }
        switch (radiantWin, playerSide ) {
        case (true, .radiant):
            return .win
        case (false, .radiant):
            return .lose
        case (true, .dire):
            return .lose
        case (false, .dire):
            return .win
        default:
            return nil
        }
    }
    func formatGameMode(gameMode: Int) -> GameMode {
        if gameMode == 23 {
            return .turbo
        } else {
            return .allPick
        }
    }
    func formatDuration(duration: Int) -> String {
        let minutes = duration / 60
        let seconds = duration % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

enum GameResult {
    case win
    case lose
}
enum PlayerSide {
    case radiant
    case dire
}
