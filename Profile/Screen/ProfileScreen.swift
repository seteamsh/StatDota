import SwiftUI

struct ProfileView: View {
    
    @StateObject var vm: ProfileViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                PlayerInfo(
                    winLose: vm.winLose,
                    winLoseTurbo: vm.winLoseTurbo,
                    winRate: vm.winRate,
                    winRateTurbo: vm.winRateTurbo,
                    profile: vm.profile,
                    isTurbo: $vm.isTurbo
                )
                
                Picker("", selection: $vm.selectedPage) {
                    ForEach(vm.pages, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.bottom, 20)
                
                switch vm.selectedPage {
                case .heroes:
                    PlayerHeroesView(
                        playerHeroes: vm.isTurbo ? vm.playerHeroesTurbo : vm.playerHeroes)
                case .matches:
                    PlayerMatchesView(
                        vm: PlayerMatchesViewModel(matches: vm.isTurbo ? vm.matchesTurbo : vm.matches) {
                            if vm.isTurbo {
                                vm.offsetTurbo += vm.limit
                                vm.loadPlayerMatches()
                            } else {
                                vm.offset += vm.limit
                                vm.loadPlayerMatches()
                            }
                            
                            
                        }
                    )
                    //.border(.gray.opacity(0.3), width: 1)
                }
            }
            .padding(.horizontal, 5)
            .onChange(of: vm.isTurbo) {
                vm.loadWinLose()
                vm.loadPlayerHeroes(id: vm.profile.accountId, isTurbo: vm.isTurbo)
                if vm.matches.isEmpty {
                    vm.loadPlayerMatches()
                }
                if vm.matchesTurbo.isEmpty {
                    vm.loadPlayerMatches()
                }
                
            }
        }
    }
}

#Preview {
    ProfileView(
        vm: ProfileViewModel(profiile: Profile.dummyData)
    )
}
