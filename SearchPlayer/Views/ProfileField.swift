//
//  PlayerField.swift
//  StatDota
//
//  Created by Temirlan Zhumashov on 28.03.2026.
//

import SwiftUI

struct ProfileField: View {
    var profile: Profile?
    var errorMessage: String?
    var body: some View {
        if let profile = profile {
            NavigationLink {
                ProfileView(vm: ProfileViewModel(profiile: profile))
            } label: {
                HStack {
                    Spacer()
                    AsyncImage(url: URL(string: profile.avatarmedium)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipped()
                            .clipShape(.circle)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 50, height: 50)
                    Text(profile.personaname)
                        .foregroundStyle(.white)
                        .font(.title)
                    Spacer()
                }
            }
            
        } else {
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    ProfileField(profile: Profile.dummyData, errorMessage: "jibberish")
}
