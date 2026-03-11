import SwiftUI

struct ProfileView: View {
    
    @StateObject var vm: ProfileViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                PlayerInfo(profile: vm.profile, win: vm.win, lose: vm.lose, winRate: vm.winRate, isTurbo: $vm.isTurbo)
                
                Picker("", selection: $vm.selectedPage) {
                    ForEach(ProfileViewModel.Pages.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.bottom, 20)
                
                switch vm.selectedPage {
                case .heroes:
                    PlayerHeroesView(vm: PlayerHeroesViewModel(playerHeroes: vm.playerHeroes, heroes: vm.heroes, isTurbo: vm.isTurbo))
                case .matches:
                    PlayerMatchesView(vm: PlayerMatchesViewModel(profileID: vm.profile.accountId, isTurbo: vm.isTurbo, heroes: vm.heroes))
                        .border(.gray.opacity(0.3), width: 1)
                }
                
            }
            
            .onChange(of: vm.isTurbo) {
                vm.loadWinLose(id: vm.profile.accountId, isTurbo: vm.isTurbo)
                
                vm.loadPlayerHeroes(id: vm.profile.accountId, isTurbo: vm.isTurbo)
                
                
            }

            .onAppear {
                vm.loadHeroes()
                vm.loadWinLose(id: vm.profile.accountId, isTurbo: vm.isTurbo)
                vm.loadPlayerHeroes(id: vm.profile.accountId, isTurbo: vm.isTurbo)
                
            }
            .padding(.horizontal, 5)
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
