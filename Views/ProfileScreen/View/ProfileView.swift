import SwiftUI

struct ProfileView: View {
    @StateObject var vm = ProfileViewModel()
    @StateObject var playerMatchesVM = PlayerMatchesViewModel()
    @State var isTurbo = false
    let profile: Profile
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                PlayerInfo(profile: profile, win: vm.win, lose: vm.lose, winRate: vm.winRate, isTurbo: $isTurbo)
                
                Picker("", selection: $vm.selectedPage) {
                    ForEach(ProfileViewModel.Pages.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.bottom, 20)
                
                switch vm.selectedPage {
                case .heroes:
                    PlayerHeroesView(profileVM: vm, isTurbo: $isTurbo, profile: profile)
                case .matches:
                    PlayerMatchesView(vm: playerMatchesVM, profileVM: vm, profileID: profile.accountId, isTurbo: $isTurbo)
                        .border(.gray.opacity(0.3), width: 1)
                }
                
            }
            
            .onChange(of: isTurbo) {
                vm.loadWinLose(id: profile.accountId, isTurbo: isTurbo)
                
                vm.loadPlayerHeroes(id: profile.accountId, isTurbo: isTurbo)
                playerMatchesVM.matches = []
                playerMatchesVM.processedMatches = []
                playerMatchesVM.offset = 0
                playerMatchesVM.loadPlayerMatches(id: profile.accountId, isTurbo: isTurbo)
                    
            }
            .onChange(of: playerMatchesVM.matches) {
                playerMatchesVM.processMatches(heroes: vm.heroes)
            }
            .onAppear {
                vm.loadHeroes()
                vm.loadWinLose(id: profile.accountId, isTurbo: isTurbo)
                vm.loadPlayerHeroes(id: profile.accountId, isTurbo: isTurbo)
                playerMatchesVM.loadPlayerMatches(id: profile.accountId, isTurbo: isTurbo)
            }
            .padding(.horizontal, 5)
        }
    }
}

#Preview {
    ProfileView(profile: Profile(accountId: 1, personaname: "teste1", avatar: "fd", avatarmedium: "fdf", avatarfull: "https://www.dexerto.com/cdn-image/wp-content/uploads/2023/05/26/naruto-itachi-uchiha-mangekyou-sharingan.jpeg", profileurl: "fdf", lastLogin: "fdf"))
}
