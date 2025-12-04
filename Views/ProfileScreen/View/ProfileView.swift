//
//  ProfileView.swift
//  StatDota
//
//  Created by Temirlan Zhumashov on 04.12.2025.
//

import SwiftUI

struct ProfileView: View {
    @State var isTurbo = false
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("e1")
                        .font(.title)
                    
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 150, height: 150)
                }
                .padding()
                .border(.blue, width: 2)
                VStack(alignment: .leading, spacing: 10) {
                    Text("WINS: 943")
                    Text("LOSSES: 926")
                    Text("WINRATE: 50.45%")
                    HStack(spacing: 20) {
                        Text("TURBO")
                        Toggle("", isOn: $isTurbo)
                    }
                    .labelsHidden()
                }
            }
            Spacer()
        }
    }
}

#Preview {
    ProfileView()
}
