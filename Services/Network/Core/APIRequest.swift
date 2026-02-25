import Foundation

class APIRequest<Resource: APIResource> {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}

extension APIRequest: NetworkRequest {
    
    func decode(_ data: Data) throws -> Resource.ModelType {
        let decoded = try JSONDecoder().decode(Resource.ModelType.self, from: data)
        return decoded
    }
    func execute(withCompletion completion: @escaping (Result<ModelType?, NetworkError>) -> Void) {
        load(resource.url, withCompletion: completion)
    }
}
