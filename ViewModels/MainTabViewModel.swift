import Foundation

class MainTabViewModel: ObservableObject {
    @Published var selectedTab: Tab = .search
    
    enum Tab: Hashable {
        case search
        case favorites
    }
}
