import SwiftUI

struct PlayerMatchesView: View {
    
    @ObservedObject var vm: PlayerMatchesViewModel
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                VStack(spacing: 0) {
                    PlayerMatchesHeader()
                    ForEach(vm.processedMatches, id: \.matchID) { match in
                        PlayerMatchCard(match: match)
                    }
                    if vm.isLoading {
                        ProgressView()
                    }
                }
            }
            
            Button {
                vm.loadPlayerMatches()
            } label: {
                Text("download more")
            }
        }
        .onChange(of: vm.matches) {
            vm.processMatches()
        }
        
        .onChange(of: vm.isTurbo) {
            vm.matches = []
            vm.processedMatches = []
            vm.offset = 0
            vm.loadPlayerMatches()
        }
    }
}

#Preview {
    PlayerMatchesView(
        vm: PlayerMatchesViewModel(profileID: 117124649, isTurbo: false, heroes: [Hero]())
    )
}
