import SwiftUI

struct ProfileView: View {
    
    @StateObject var vm: ProfileViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                PlayerInfo(vm: PlayerInfoViewModel(winLose: vm.winLose, winLoseTurbo: vm.winLoseTurbo, winRate: vm.winRate, winRateTurbo: vm.winRateTurbo, profile: vm.profile), isTurbo: $vm.isTurbo)
                    .onChange(of: vm.isTurbo) {
                        vm.loadWinLose()
                    }
                Picker("", selection: $vm.selectedPage) {
                    ForEach(vm.pages, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.bottom, 20)
                
                switch vm.selectedPage {
                case .heroes:
                    switch vm.isTurbo {
                    case true:
                        PlayerHeroesView(vm: PlayerHeroesViewModel(playerHeroes: vm.mergedPlayerHeroesTurbo))
                    case false:
                        PlayerHeroesView(vm: PlayerHeroesViewModel(playerHeroes: vm.mergedPlayerHeroes))
                    }
                case .matches:
                    switch vm.isTurbo {
                    case true:
                        PlayerMatchesView(vm: PlayerMatchesViewModel(matches: vm.processedMatchesTurbo) {
                            vm.loadPlayerMatches()
                            vm.offsetTurbo = 20
                        })
                    case false:
                        PlayerMatchesView(vm: PlayerMatchesViewModel(matches: vm.processedMatches) {
                            vm.loadPlayerMatches()
                            vm.offset = 20
                        })
                    }
                        //.border(.gray.opacity(0.3), width: 1)
                }
                    
                
            }
            .padding(.horizontal, 5)
            .onAppear {
                vm.loadPlayerHeroes(id: vm.profile.accountId, isTurbo: vm.isTurbo)
                vm.loadPlayerMatches()
                
            }
            .onChange(of: vm.isTurbo) {
                vm.loadPlayerHeroes(id: vm.profile.accountId, isTurbo: vm.isTurbo)
                vm.loadPlayerMatches()
            }
            .onChange(of: vm.playerHeroes) {
                vm.getMergePlayerHeroes()
            }
            .onChange(of: vm.playerHeroesTurbo) {
                vm.getMergePlayerHeroes()
            }
            .onChange(of: vm.matchesTurbo) {
                vm.getProcessMatches()
            }
            .onChange(of: vm.matches) {
                vm.getProcessMatches()
            }
        }
    }
}

#Preview {
    ProfileView(
        vm: ProfileViewModel(profiile: Profile(
            accountId: 1,
            personaname: "teste1",
            avatar: "fd",
            avatarmedium: "fdf",
            avatarfull: "https://www.dexerto.com/cdn-image/wp-content/uploads/2023/05/26/naruto-itachi-uchiha-mangekyou-sharingan.jpeg",
            profileurl: "fdf",
            lastLogin: "fdf"
            )
        )
    )
}
