import SwiftUI

struct PlayerMatchesView: View {
    @StateObject var vm = PlayerMatchesViewModel()
    @StateObject var profileVM: ProfileViewModel
    let profileID: Int
    var gameMode: GameMode
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.processedMatches, id: \.matchID) { match in
                    PlayerMatchCard(match: match)
                }
            }
        }
        .onChange(of: vm.matches) {
            vm.processMatches(heroes: profileVM.heroes)
        }
        .onChange(of: gameMode) {
            vm.getPlayerMatches(playerId: profileID, gameMode: gameMode)
        }
        .onAppear {
            vm.getPlayerMatches(playerId: profileID, gameMode: gameMode)
        }
    }
}

#Preview {
    PlayerMatchesView(
        profileVM: ProfileViewModel(), profileID: 117124649,
        gameMode: .allPick
    )
}
