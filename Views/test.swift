//
//  test.swift
//  StatDota
//
//  Created by Temirlan Zhumashov on 09.12.2025.
//

import SwiftUI

struct test: View {
    @State var heroes = [Hero]()
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(heroes, id: \.id) { hero in
                    HStack {
                        AsyncImage(
                            url: URL(
                                string: "https://cdn.steamstatic.com/apps/dota2/images/dota_react/heroes/\(hero.name.replacingOccurrences(of: "npc_dota_hero_", with: "")).png?"
                            )
                        ) { imgae in
                            imgae.resizable()
                                .frame(width: 100, height: 70)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        Text("\(hero.id)")
                        
                        Text(hero.localizedName)
                    }
                }
            }
            .onAppear {
                NetworkManager.shared.fetchHeroes { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let heroes):
                            self.heroes = heroes
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    test()
}
