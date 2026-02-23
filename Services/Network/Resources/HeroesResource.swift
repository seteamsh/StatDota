import Foundation

struct HeroesResource: APIResource {
    typealias ModelType = [Hero]
    
    var methodPath: String {
        "/api/heroes"
    }
}
