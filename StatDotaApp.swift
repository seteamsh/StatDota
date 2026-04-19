//
//  StatDotaApp.swift
//  StatDota
//
//  Created by Temirlan Zhumashov on 23.11.2025.
//

import SwiftUI

@main
struct StatDotaApp: App {
    @StateObject var HeroesData = HeroesViewModel()
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(HeroesData)
        }
    }
}
