import Foundation

class MainTabViewModel: ObservableObject {
    @Published var selectedTab: Tab = .search
    
    
}

extension MainTabViewModel {
    enum Tab: Hashable {
        case search
        case favorites
    }
}
