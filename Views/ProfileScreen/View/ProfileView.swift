import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var vm: ProfileViewModel
    
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
                    PlayerMatchesView(vm: PlayerMatchesViewModel(profileID: vm.profile.accountId, isTurbo: vm.isTurbo, heroes: vm.heroes))
                        .border(.gray.opacity(0.3), width: 1)

                }
                    
                
            }
            .padding(.horizontal, 5)
            .onAppear {
                vm.loadPlayerHeroes(id: vm.profile.accountId, isTurbo: vm.isTurbo)
            }
            .onChange(of: vm.isTurbo) {
                vm.loadPlayerHeroes(id: vm.profile.accountId, isTurbo: vm.isTurbo)
            }
            .onChange(of: vm.playerHeroes) {
                vm.getMergePlayerHeroes()
            }
            .onChange(of: vm.playerHeroesTurbo) {
                vm.getMergePlayerHeroes()
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
