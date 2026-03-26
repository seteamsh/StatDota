import SwiftUI

struct PlayerMatchesView: View {
    
    var vm: PlayerMatchesViewModel
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                VStack(spacing: 0) {
                    PlayerMatchesHeader()
                    ForEach(vm.matches, id: \.matchID) { match in
                        PlayerMatchCard(match: match)
                    }
                    if vm.isLoading {
                        ProgressView()
                    }
                }
            }
            
            Button {
                vm.action()
            } label: {
                Text("download more")
            }
        }
    }
}

#Preview {
    PlayerMatchesView(
        vm: PlayerMatchesViewModel(
            matches: [PlayerMatchesProcessed(
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
            )],action: {}
        )
    )
}
