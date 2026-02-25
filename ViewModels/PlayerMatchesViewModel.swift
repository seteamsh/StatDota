import Foundation
import SwiftUI

class PlayerMatchesViewModel: ObservableObject {
    //MARK: Properties--
    @Published var matches = [PlayerMatches]()
    @Published var items = [Item]()
    @Published private(set) var isLoading = false
    @Published private(set) var canLoadMore = true
    @Published var processedMatches = [PlayerMatchesProcessed]()
    
    var offset: Int = 0
    private var limit : Int = 20
    
    
    //MARK: Methods-
    
    func loadPlayerMatches(id: Int, isTurbo: Bool) {
        guard !isLoading else { return }
        isLoading = true
        let request = APIRequest(resource: PlayerMatchesResource(id: id, isTurbo: isTurbo, offset: offset, limit: limit))
        request.execute { result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.matches += result ?? []
                    self.offset += self.limit
                    self.isLoading = false
                }
            case .failure(let error):
                print(error)
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
                //items: <#T##[Item]#>
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
        return heroes.first(where: { $0.id == heroId })!
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
