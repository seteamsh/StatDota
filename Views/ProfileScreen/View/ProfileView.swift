import SwiftUI

struct ProfileView: View {
    @StateObject var vm = ProfileViewModel()
    @State var isTurbo = false
    
    let profile: Profile
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                HStack(spacing: 5) {
                    AsyncImage(url: URL(string: profile.avatarfull)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width / 2)
                    //.border(.red, width: 2)
                    VStack(alignment: .leading, spacing: 5) {
                        Text(profile.personaname)
                            .font(.title)
                        HStack {
                            Text("WINS")
                            Text("\(vm.win)")
                        }
                        HStack {
                            Text("LOSE")
                            Text("\(vm.lose)")
                        }
                        HStack {
                            Text("WINRATE")
                            Text("\(String(format: "%.2f", vm.winRate))%")
                        }
                        HStack(spacing: 20) {
                            Text("TURBO")
                            Toggle("", isOn: $isTurbo)
                                
                        }
                        .labelsHidden()
                    }
                    .frame(width: UIScreen.main.bounds.width / 2, alignment: .leading)
                    //.border(.blue, width: 2)
                }
                .frame(height: UIScreen.main.bounds.height / 5)
                //.border(.black, width: 2)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        Button {
                            
                        } label: {
                            Text("Heroes")
                                .foregroundStyle(.white)
                                .padding(10)
                                .background(.black)
                                .clipShape(.buttonBorder)
                        }
                        Button {
                            
                        } label: {
                            Text("Matches")
                                .foregroundStyle(.white)
                                .padding(10)
                                .background(.black)
                                .clipShape(.buttonBorder)
                        }
                    }
                    .padding(20)
                    
                }
                PlayerHeroesView(isTurbo: $isTurbo, profile: profile)
            }
            .onChange(of: isTurbo) {
                vm.loadWinLose(id: profile.accountId, isTurbo: isTurbo)
            }
            .onAppear {
                vm.loadWinLose(id: profile.accountId, isTurbo: isTurbo)
            }
        }
    }
}

#Preview {
    ProfileView(profile: Profile(accountId: 1, personaname: "teste1", avatar: "fd", avatarmedium: "fdf", avatarfull: "https://www.dexerto.com/cdn-image/wp-content/uploads/2023/05/26/naruto-itachi-uchiha-mangekyou-sharingan.jpeg", profileurl: "fdf", lastLogin: "fdf"))
}
