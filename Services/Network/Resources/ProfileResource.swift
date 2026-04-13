import Foundation

struct ProfileResource: APIResource {
    typealias ModelType = Wrapper
    var id: Int?
    
    var methodPath: String {
        return "/api/players/\(id!)"
    }
}
