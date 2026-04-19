import Foundation

final class MatchesViewModel: ObservableObject {
    
    // MARK: Properties -
    @Published var matches = [PlayerMatchesProcessed]()
    @Published var matchesTurbo = [PlayerMatchesProcessed]()
    
    
    var profileID: Int
    var offset = 0
    var offsetTurbo = 0
    var limit = 20
    var isLoading = false
    private var request: APIRequest<PlayerMatchesResource>?
    
    init(profileID: Int) {
        self.profileID = profileID
    }
    
    // MARK: Methods -
    func loadPlayerMatches(isTurbo: Bool, heroes: [Hero]) {
        
        guard !isLoading else { return }
        
        isLoading = true
        
        let resource = PlayerMatchesResource(id: profileID, isTurbo: isTurbo, offset: offset, limit: limit)
        let request = APIRequest(resource: resource)
        self.request = request
        
        request.execute { result in
            
            DispatchQueue.main.async {
                
                self.isLoading = false
                print("request PlayerMatches isTurbo: \(isTurbo)")
                switch result {
                case .success(let result):
                    switch isTurbo {
                    case true:
                        self.matchesTurbo += self.processMatches(heroes: heroes, matches: result ?? [])
                        print("offsetTurbo: \(self.offsetTurbo)")
                    case false:
                        self.matches += self.processMatches(heroes: heroes, matches: result ?? [])
                        print("offset: \(self.offset)")
                    }
                    
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func processMatches(heroes: [Hero], matches: [PlayerMatches]) -> [PlayerMatchesProcessed] {
        return matches.map { match in
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
        return heroes.first(where: { $0.id == heroId })!
    }
}
