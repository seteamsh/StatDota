import SwiftUI

struct PlayerMatchesView: View {
    @StateObject var vm = PlayerMatchesViewModel()
    @ObservedObject var profileVM: ProfileViewModel
    let profileID: Int
    var gameMode: GameMode
    var body: some View {
        ScrollView(.horizontal) {
            VStack {
                ForEach(vm.processedMatches, id: \.matchID) { match in
                    PlayerMatchCard(match: match)
                }
                if vm.isLoading {
                    ProgressView()
                }
            }
            Button {
                vm.getPlayerMatches(playerId: profileID, gameMode: gameMode)
            } label: {
                Text("download more")
            }

        }
        .onChange(of: vm.matches) {
            vm.processMatches(heroes: profileVM.heroes)
        }
        .onChange(of: gameMode) {
            vm.matches = []
            vm.offset = 0
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
