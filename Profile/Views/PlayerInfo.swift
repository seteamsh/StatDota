import SwiftUI

struct PlayerInfo: View {
    
    var winLose: WinLose?
    var winLoseTurbo: WinLose?
    
    var winRate: Double?
    var winRateTurbo: Double?
    
    let profile: Profile
    
    @Binding var isTurbo: Bool
    
    var body: some View {
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
                    switch isTurbo {
                    case true:
                        if let win = winLoseTurbo?.win {
                            Text("\(win)")
                        } else {
                            ProgressView()
                        }
                    case false:
                        if let win = winLose?.win {
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
                        if let lose = winLoseTurbo?.lose {
                            Text("\(lose)")
                        } else {
                            ProgressView()
                        }
                    case false:
                        if let lose = winLose?.lose {
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
                        if let winRate = winRateTurbo {
                            Text("\(String(format: "%.2f", winRate))%")
                        } else {
                            ProgressView()
                        }
                    case false:
                        if let winRate = winRate {
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
    PlayerInfo(profile: Profile.dummyData, isTurbo: .constant(false))
}
