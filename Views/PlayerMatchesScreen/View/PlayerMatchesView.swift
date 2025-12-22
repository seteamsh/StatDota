import SwiftUI

struct PlayerMatchesView: View {
    @StateObject var vm = PlayerMatchesViewModel()
    @ObservedObject var profileVM: ProfileViewModel
    var body: some View {
        ScrollView(.horizontal) {
            ForEach(vm.processedMatches, id: \.matchID) { match in
                LazyVStack {
                    PlayerMatchCard(match: match)
                }
            }
        }
        .onChange(of: profileVM.matches) {
            vm.processMatches(matches: profileVM.matches, heroes: profileVM.heroes)
        }
    }
}

#Preview {
    PlayerMatchesView(profileVM: ProfileViewModel())
}
