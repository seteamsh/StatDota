import SwiftUI

struct PlayerMatchesView: View {
    @StateObject var vm = PlayerMatchesViewModel()
    @ObservedObject var profileVM: ProfileViewModel
    var body: some View {
        ScrollView(.horizontal) {
            LazyVStack {
                ForEach(vm.processedMatches.indices, id: \.self) { index in
                    let match = vm.processedMatches[index]
                    PlayerMatchCard(match: match)
                        .onAppear {
                            if index == vm.processedMatches.count - 1 {
                                
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
    PlayerMatchesView(profileVM: ProfileViewModel())
}
