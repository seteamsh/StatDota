import SwiftUI

struct PlayerMatchesView: View {
    @StateObject var vm = PlayerMatchesViewModel()
    @ObservedObject var profileVM: ProfileViewModel
    let profileID: Int
    var gameMode: GameMode
    var body: some View {
        ScrollView(.horizontal) {
                ForEach(vm.processedMatches, id: \.matchID) { match in
                    PlayerMatchCard(match: match)
                        .onAppear {
                            vm.loadMatchesIfNeeded(id: profileID, gameMode: gameMode, currentItem: match )
                        }
                }
                if vm.isLoading {
                    ProgressView()
                }
                
            
            
        
        }
        .onChange(of: vm.matches) {
            vm.processMatches(heroes: profileVM.heroes)
        }
        .onChange(of: gameMode) {
            vm.processedMatches = []
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
