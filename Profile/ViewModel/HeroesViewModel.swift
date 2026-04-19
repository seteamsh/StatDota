import Foundation

final class HeroesViewModel: ObservableObject {
    @Published private(set) var heroes = [Hero]()
    @Published private(set) var isLoading: Bool = false
    private var request: APIRequest<HeroesResource>?
    
    func loadIfNeeded() {
        guard heroes.isEmpty else { return }
        loadHeroes()
    }
    
    func loadHeroes() {
        guard !isLoading else { return }
        isLoading = true
        let resource = HeroesResource()
        let request = APIRequest(resource: resource)
        self.request = request
        
        request.execute { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let result):
                        self?.heroes = result ?? []
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
