//
//  PlayerMatchesView.swift
//  StatDota
//
//  Created by Temirlan Zhumashov on 11.12.2025.
//

import SwiftUI

struct PlayerMatchesView: View {
    @StateObject var vm = PlayerMatchesViewModel()
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(vm.processedMatches, id: \.matchID) { match in
                    HStack {
                        Text("\(match.matchResult ?? .win)")
                        Text("\(match.gameMode)")
                        VStack {
                            Text(match.duration)
                            Text("\(match.playerSide)")
                        }
                        
                        Text("\(match.kills)")
                        Text("\(match.deaths)")
                        Text("\(match.assists)")
                    }
                }
            }
        }
        .onAppear {
            vm.getPlayerMatches(playerId: 117124649, gameMode: .turbo)
        }
    }
}

#Preview {
    PlayerMatchesView()
}
