import SwiftUI

struct ProfileView: View {
    @StateObject var vm = ProfileViewModel()
    @StateObject var playerMatchesVM = PlayerMatchesViewModel()
    @State var isTurbo = false
    let profile: Profile
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                HStack(spacing: 15) {
                    AsyncImage(url: URL(string: profile.avatarfull)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    } placeholder: {
                        ZStack {
                            Rectangle()
                                .foregroundStyle(.background)
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                            ProgressView()
                        }
                    }
                    VStack(alignment: .leading, spacing: 5) {
                        Text(profile.personaname)
                            .font(.title)
                        HStack {
                            Text("WINS")
                            if let win = vm.win {
                                Text("\(win)")
                            } else {
                                ProgressView()
                            }
                        }
                        HStack {
                            Text("LOSE")
                            if let lose = vm.lose {
                                Text("\(lose)")
                            } else {
                                ProgressView()
                            }
                        }
                        HStack {
                            Text("WINRATE")
                            if let winRate = vm.winRate {
                                Text("\(String(format: "%.2f", winRate))%")
                            } else {
                                ProgressView()
                            }
                        }
                        HStack(spacing: 20) {
                            Text("TURBO")
                            Toggle("", isOn: $isTurbo)
                            
                        }
                        .labelsHidden()
                    }
                    Spacer()
                }
                .padding(.bottom, 30)
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
                vm.getPlayerHeroes(id: profile.accountId, gameMode: isTurbo ? .turbo : .allPick)
                playerMatchesVM.matches = []
                playerMatchesVM.processedMatches = []
                playerMatchesVM.offset = 0
                playerMatchesVM.getPlayerMatches(playerId: profile.accountId, gameMode: isTurbo ? .turbo : .allPick)
                    
            }
            .onChange(of: playerMatchesVM.matches) {
                playerMatchesVM.processMatches(heroes: vm.heroes)
            }
            .onAppear {
                vm.getHeroes()
                vm.loadWinLose(id: profile.accountId, isTurbo: isTurbo)
                vm.getPlayerHeroes(id: profile.accountId, gameMode: isTurbo ? .turbo : .allPick)
                playerMatchesVM.getPlayerMatches(playerId: profile.accountId, gameMode: isTurbo ? .turbo : .allPick)
            }
            .padding(.horizontal, 5)
        }
    }
}

#Preview {
    ProfileView(profile: Profile(accountId: 1, personaname: "teste1", avatar: "fd", avatarmedium: "fdf", avatarfull: "https://www.dexerto.com/cdn-image/wp-content/uploads/2023/05/26/naruto-itachi-uchiha-mangekyou-sharingan.jpeg", profileurl: "fdf", lastLogin: "fdf"))
}
