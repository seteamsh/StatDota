//
//  PlayerHeroes.swift
//  StatDota
//
//  Created by Temirlan Zhumashov on 09.12.2025.
//

import SwiftUI

struct PlayerHeroes: View {
    var heroes: [Hero]
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(heroes, id: \.id) { hero in
                    HStack {
                        Image(systemName: "person")
                            .font(.system(size: 50))
                            .frame(width: 80, height: 60)
                            .border(.black, width: 2)
                        VStack {
                            Text(hero.localizedName)
                            Text("2 moths ago")
                                .foregroundStyle(.gray)
                        }
                        Text("300")
                        Text("53.3")
                    }
                }
            }
        }
    }
}

#Preview {
    PlayerHeroes(heroes: [Hero(id: 1, name: "Antimage", localizedName: "Anti-Mage", primaryAttr: .agi, attackType: .melee, roles: [.carry], legs: 1)])
}
