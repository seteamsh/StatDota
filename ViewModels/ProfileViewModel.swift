import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var isTurbo = false
    
    //MARK: WinLose Property-
    @Published var winLose: WinLose?
    @Published var winLoseTurbo: WinLose?
    
    @Published var winRate: Double?
    @Published var winRateTurbo: Double?
    
    //
    
    @Published var errorMessage: String?
    @Published var heroes = [Hero]()
    @Published var playerHeroes = [PlayerHeroes]()
    @Published var playerHeroesTurbo = [PlayerHeroes]()
    @Published var selectedPage: Pages = .matches
    @Published var mergedPlayerHeroes = [MergedPlayerHeroes]()
    @Published var mergedPlayerHeroesTurbo = [MergedPlayerHeroes]()
    
    //MARK: Properties Load Matches -
    @Published private(set) var isLoading = false
    @Published private(set) var canLoadMore = true
    
    @Published var matches = [PlayerMatches]()
    @Published var matchesTurbo = [PlayerMatches]()
    @Published var processedMatches = [PlayerMatchesProcessed]()
    @Published var processedMatchesTurbo = [PlayerMatchesProcessed]()
    var offset = 0
    var offsetTurbo = 0
    private var limit = 20
    
    var pages: [Pages] = [.matches, .heroes]
    let profile: Profile
    
    init(profiile: Profile) {
        self.profile = profiile
        loadHeroes()
        loadWinLose()
    }
    
    //MARK: -WinLose Methods
    func loadWinLose() {
        if winLose != nil && winLoseTurbo != nil { return }
        let request = APIRequest(resource: WinLoseResource(id: profile.accountId, isTurbo: isTurbo))
        request.execute { result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    print("request loadWinLose")
                    switch self.isTurbo {
                    case true:
                        self.winLoseTurbo = result
                        self.winRateTurbo = self.getWinRate(win: result?.win ?? 0, lose: result?.lose ?? 0)
                    case false:
                        self.winLose = result
                        self.winRate = self.getWinRate(win: result?.win ?? 0, lose: result?.lose ?? 0)
                    }
                
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getWinRate(win: Int, lose: Int) -> Double {
        guard win + lose > 0 else {
            return 0
        }
        return Double(win) / Double(win + lose) * 100
    }
    
    func loadHeroes() {
        let request = APIRequest(resource: HeroesResource())
        request.execute { result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.heroes = result ?? []
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadPlayerHeroes(id: Int, isTurbo: Bool) {
        if !playerHeroes.isEmpty && !playerHeroesTurbo.isEmpty {
            return
        }
        let request = APIRequest(resource: PlayerHeroesResource(id: id, isTurbo: isTurbo))
        request.execute { result in
            print("loadPlayerHeroes\(isTurbo)")
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    switch isTurbo {
                    case true:
                        self.playerHeroesTurbo = result ?? []
                    case false:
                        self.playerHeroes = result ?? []
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getMergePlayerHeroes() {
        switch isTurbo {
            case true:
            mergedPlayerHeroesTurbo = mergPlayerHeroes(playerHeroes: playerHeroesTurbo, heroes: heroes)
        case false:
            mergedPlayerHeroes = mergPlayerHeroes(playerHeroes: playerHeroes, heroes: heroes)
        }
    }
    
    func mergPlayerHeroes(playerHeroes: [PlayerHeroes], heroes: [Hero]) -> [MergedPlayerHeroes] {
        return playerHeroes.compactMap { playerHero in
            guard let heroes = heroes.first(where: { $0.id == playerHero.heroID }) else { return nil }
            return MergedPlayerHeroes(
                id: playerHero.heroID,
                name: heroes.localizedName,
                imageURL: heroes.name,
                win: playerHero.win,
                games: playerHero.games,
                lastPlayed: playerHero.lastPlayed,
                winRate: playerHero.games == 0 ? 0 : Double(playerHero.win) / Double(playerHero.games) * 100.00)
        }
    }
    enum Pages: String, CaseIterable {
        
        case matches = "MATCHES"
        case heroes = "HEROES"
    }
    
    //MARK: -Load Matches Service
    func loadPlayerMatches() {
        if !matches.isEmpty && !matchesTurbo.isEmpty { return }
        guard !isLoading else { return }
        
        isLoading = true
        let request = APIRequest(
            resource: PlayerMatchesResource(
                id: profile.accountId,
                isTurbo: isTurbo,
                offset: isTurbo ? self.offsetTurbo : self.offset,
                limit: limit
            )
        )
        request.execute { result in
            print("request PlayerMatches isTurbo: \(self.isTurbo)")
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    switch self.isTurbo {
                    case true:
                        self.matchesTurbo += result ?? []
                    case false:
                        self.matches += result ?? []
                        
                    }
                    self.isLoading = false
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getProcessMatches() {
        switch isTurbo {
        case true: processedMatchesTurbo = processMatches(matches: matchesTurbo)
        case false: processedMatches = processMatches(matches: matches)
        }
    }
    
    func processMatches(matches: [PlayerMatches]) -> [PlayerMatchesProcessed] {
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


extension Int {
    func timeAgo() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))

        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.unitsStyle = .full   // .short → "5 мин назад"

        return formatter.localizedString(for: date, relativeTo: Date())
    }
}
