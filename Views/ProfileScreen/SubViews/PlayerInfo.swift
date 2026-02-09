//
//  PlayerInfo.swift
//  StatDota
//
//  Created by Temirlan Zhumashov on 09.02.2026.
//

import SwiftUI

struct PlayerInfo: View {
    var profile: Profile
    var win: Int?
    var lose: Int?
    var winRate: Double?
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
                    if let win = win {
                        Text("\(win)")
                    } else {
                        ProgressView()
                    }
                }
                HStack {
                    Text("LOSE")
                    if let lose = lose {
                        Text("\(lose)")
                    } else {
                        ProgressView()
                    }
                }
                HStack {
                    Text("WINRATE")
                    if let winRate = winRate {
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
    }
}

#Preview {
    PlayerInfo(profile: Profile(accountId: 1, personaname: "e1", avatar: "", avatarmedium: "", avatarfull: "", profileurl: "", lastLogin: ""), isTurbo: .constant(false))
}
