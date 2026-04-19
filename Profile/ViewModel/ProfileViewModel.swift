import SwiftUI

class ProfileViewModel: ObservableObject {
    
    // MARK: Properties -
    @Published var isTurbo = false
    
    @Published var selectedPage: Pages = .matches
    
    @Published private(set) var canLoadMore = true

    var pages: [Pages] = [.matches, .heroes]
    var profile: Profile
    
    let statsVM: ProfileStatsViewModel
    let playerHeroesVM: PlayerHeroesViewModel
    let matchesVM: MatchesViewModel
    init(profiile: Profile) {
        self.profile = profiile
        self.statsVM = ProfileStatsViewModel(profileID: profiile.accountId)
        self.playerHeroesVM = PlayerHeroesViewModel(profileID: profiile.accountId)
        self.matchesVM = MatchesViewModel(profileID: profiile.accountId)
    }
    
    enum Pages: String, CaseIterable {
        case matches = "MATCHES"
        case heroes = "HEROES"
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
