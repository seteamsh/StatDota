import SwiftUI

struct PlayerMatchesView: View {
    @StateObject var vm = PlayerMatchesViewModel()
    @ObservedObject var profileVM: ProfileViewModel
    let profileID: Int
    let gameMode: GameMode
    var body: some View {
        ScrollView(.horizontal) {
            VStack {
                ForEach(vm.processedMatches.indices, id: \.self) { index in
                    let match = vm.processedMatches[index]
                    PlayerMatchCard(match: match)
                        .onAppear {
                            if index == vm.processedMatches.count - 1 {
                                profileVM.getPlayerMatches(playerId: profileID, gameMode: gameMode)
                            }
                        }
                }
            }
        }
        .onChange(of: profileVM.matches) {
            vm.processMatches(matches: profileVM.matches, heroes: profileVM.heroes)
        }
    }
}

#Preview {
    PlayerMatchesView(profileVM: ProfileViewModel(), profileID: 117124649, gameMode: .allPick)
}
