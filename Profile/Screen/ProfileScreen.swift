import SwiftUI

struct ProfileView: View {
    
    @StateObject var vm: ProfileViewModel
    @EnvironmentObject var heroes: HeroesViewModel
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                PlayerInfo(
                    vm: vm.statsVM,
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
                    PlayerHeroesView(vm: vm.playerHeroesVM)
                case .matches:
                    PlayerMatchesView(vm: vm.matchesVM)
//                    PlayerMatchesView(
//                        vm: PlayerMatchesViewModel(matches: vm.isTurbo ? vm.matchesVM.matchesTurbo : vm.matchesVM.matches) {
//                            if vm.isTurbo {
//                                vm.matchesVM.offsetTurbo += vm.matchesVM.limit
//                                vm.matchesVM.loadPlayerMatches(
//                                    isTurbo: vm.isTurbo,
//                                    heroes: vm.heroesVM.heroes
//                                )
//                            } else {
//                                vm.matchesVM.offset += vm.matchesVM.limit
//                                vm.matchesVM.loadPlayerMatches(
//                                    isTurbo: vm.isTurbo,
//                                    heroes: vm.heroesVM.heroes
//                                )
//                            }
//                            
//                            
//                        }
//                    )
                    //.border(.gray.opacity(0.3), width: 1)
                }
            }
            .padding(.horizontal, 5)
            .onAppear {
                heroes.loadIfNeeded()
                vm.statsVM.loadWinLose(isTurbo: vm.isTurbo)
                guard !heroes.heroes.isEmpty else { return }
                vm.matchesVM.loadPlayerMatches(
                    isTurbo: vm.isTurbo,
                    heroes: heroes.heroes
                )
                vm.playerHeroesVM.loadPlayerHeroes(
                    heroes: heroes.heroes,
                    isTurbo: vm.isTurbo
                )
            }
            .onChange(of: heroes.heroes) {
                guard !heroes.heroes.isEmpty else { return }
                vm.matchesVM.loadPlayerMatches(
                    isTurbo: vm.isTurbo,
                    heroes: heroes.heroes
                )
                vm.playerHeroesVM.loadPlayerHeroes(
                    heroes: heroes.heroes,
                    isTurbo: vm.isTurbo
                )
            }
            .onChange(of: vm.isTurbo) {
                vm.statsVM.loadWinLose(isTurbo: vm.isTurbo)
                vm.playerHeroesVM.loadPlayerHeroes(
                    heroes: heroes.heroes,
                    isTurbo: vm.isTurbo
                )
                if vm.matchesVM.matches.isEmpty {
                    vm.matchesVM.loadPlayerMatches(
                        isTurbo: vm.isTurbo,
                        heroes: heroes.heroes
                    )
                }
                if vm.matchesVM.matchesTurbo.isEmpty {
                    vm.matchesVM.loadPlayerMatches(
                        isTurbo: vm.isTurbo,
                        heroes: heroes.heroes
                    )
                }
                
            }
        }
    }
}

#Preview {
    ProfileView(
        vm: ProfileViewModel(
            profiile: Profile.dummyData
        )
    )
}
