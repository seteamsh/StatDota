import SwiftUI

struct PlayerInfo: View {
    
    var vm: PlayerInfoViewModel
    
    @Binding var isTurbo: Bool
    
    var body: some View {
        HStack(spacing: 15) {
            AsyncImage(url: URL(string: vm.profile.avatarfull)) { image in
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
                Text(vm.profile.personaname)
                    .font(.title)
                HStack {
                    Text("WINS")
                    switch isTurbo {
                    case true:
                        if let win = vm.winLoseTurbo?.win {
                            Text("\(win)")
                        } else {
                            ProgressView()
                        }
                    case false:
                        if let win = vm.winLose?.win {
                            Text("\(win)")
                        } else {
                            ProgressView()
                        }
                    }
                }
                HStack {
                    Text("LOSE")
                    switch isTurbo {
                    case true:
                        if let lose = vm.winLoseTurbo?.lose {
                            Text("\(lose)")
                        } else {
                            ProgressView()
                        }
                    case false:
                        if let lose = vm.winLose?.lose {
                            Text("\(lose)")
                        } else {
                            ProgressView()
                        }
                    }
                }
                HStack {
                    Text("WINRATE")
                    switch isTurbo {
                    case true:
                        if let winRate = vm.winRateTurbo {
                            Text("\(String(format: "%.2f", winRate))%")
                        } else {
                            ProgressView()
                        }
                    case false:
                        if let winRate = vm.winRate {
                            Text("\(String(format: "%.2f", winRate))%")
                        } else {
                            ProgressView()
                        }
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
    }
}

#Preview {
    PlayerInfo(
        vm: PlayerInfoViewModel(
            profile: Profile(
                accountId: 1,
                personaname: "e1",
                avatar: "",
                avatarmedium: "",
                avatarfull: "",
                profileurl: "",
                lastLogin: ""
            )
        ), isTurbo: .constant(false)
    )
}
