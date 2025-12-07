import SwiftUI

struct ProfileView: View {
    @StateObject var vm = ProfileViewModel()
    @State var isTurbo = true
   
    let profile: Profile
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                VStack {
                    AsyncImage(url: URL(string: profile.avatarfull)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .scaledToFit()
                    .frame(width: 160, height: 140)
                }
                VStack(alignment: .leading, spacing: 5) {
                    Text(profile.personaname)
                        .font(.title)
                    Text("WINS: \(vm.win)")
                    Text("LOSSES: \(vm.lose)")
                    Text("WINRATE: 50.45%")
                    HStack(spacing: 20) {
                        Text("TURBO")
                        Toggle("", isOn: $isTurbo)
                    }
                    .labelsHidden()
                }
            }
            .padding(.horizontal, 20)
            Spacer()
            Button {
                vm.loadWinLose(id: profile.accountId, isTurbo: isTurbo)
            } label: {
                Text("Press")
            }

        }
        .onAppear {
            vm.loadWinLose(id: profile.accountId, isTurbo: isTurbo)
        }
    }
}

#Preview {
    ProfileView(profile: Profile(accountId: 1, personaname: "teste1", avatar: "fd", avatarmedium: "fdf", avatarfull: "https://www.dexerto.com/cdn-image/wp-content/uploads/2023/05/26/naruto-itachi-uchiha-mangekyou-sharingan.jpeg", profileurl: "fdf", lastLogin: "fdf"))
}
