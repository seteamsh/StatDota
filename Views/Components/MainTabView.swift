import SwiftUI

struct MainTabView: View {
    @StateObject var vm = MainTabViewModel()
    var body: some View {
        TabView(selection: $vm.selectedTab) {
            FavoritesView()
                .tag(MainTabViewModel.Tab.favorites)
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
            SearchPlayerView()
                .tag(MainTabViewModel.Tab.search)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}

#Preview {
    MainTabView()
}
