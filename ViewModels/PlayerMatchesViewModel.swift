import Foundation


class PlayerMatchesViewModel: ObservableObject {
    @Published var matches = [PlayerMatches]() 
    @Published var isLoadMore = false
    @Published var processedMatches = [PlayerMatchesProcessed]()
    
    func loadMoreIfNeeded(currentItem: PlayerMatchesProcessed, action: @escaping ()-> Void) {
        guard !isLoadMore, currentItem == processedMatches.last else { return }
        action()
    }
    
    func getPlayerMatches(playerId: Int, gameMode: GameMode) {

        NetworkManager.shared.fetchPlayerMatches(
            id: playerId,
            gameMode: gameMode,
            offset: 0,
            limit: 20
            
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let newMatches):
                    
                    self.matches = newMatches
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
    
    func processMatches(heroes: [Hero]) {
        processedMatches = matches.map { match in
            return PlayerMatchesProcessed(
                matchID: match.matchID,
                playerSide: getPlayerSide(playerSlot: match.playerSlot),
                matchResult: getGameResult(radiantWin: match.radiantWin, playerSlot: match.playerSlot),
                duration: formatDuration(duration: match.duration),
                gameMode: formatGameMode(gameMode: match.gameMode),
                lobbyType: match.lobbyType,
                hero: getHero(heroId: match.heroID, heroes: heroes),
                heroLastPlayed: match.startTime.timeAgo(),
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
    func getHero(heroId: Int, heroes: [Hero]) -> Hero {
        let hero = heroes.first(where: { $0.id == heroId })!
        return hero
    }
}

extension Int {
    func timeAgo() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))

        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.unitsStyle = .full   // .short → "5 мин назад"

        return formatter.localizedString(for: date, relativeTo: Date())
    }
}
