import SwiftUI

struct PlayerMatchesView: View {
    @ObservedObject var vm: PlayerMatchesViewModel
    @ObservedObject var profileVM: ProfileViewModel
    let profileID: Int
    @Binding var isTurbo: Bool
    
    var body: some View {
        ScrollView(.horizontal) {
            VStack(spacing: 0) {
                PlayerMatchesHeader()
                ForEach(vm.processedMatches, id: \.matchID) { match in
                    PlayerMatchCard(match: match)
                        .id(match.matchID)
                }
                if vm.isLoading {
                    ProgressView()
                }
            }
        }
        
        Button {
            vm.loadPlayerMatches(id: profileID, isTurbo: isTurbo)
        } label: {
            Text("download more")
        }
    }
}

#Preview {
    PlayerMatchesView(
        vm: PlayerMatchesViewModel(), profileVM: ProfileViewModel(), profileID: 117124649,
        isTurbo: .constant(false)
    )
}
