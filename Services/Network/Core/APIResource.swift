import Foundation

protocol APIResource {
    
    associatedtype ModelType: Decodable
    
    var methodPath: String { get }
    var queryItems: [URLQueryItem]? { get }
}

extension APIResource {
    var queryItems: [URLQueryItem]? { nil }
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.opendota.com"
        components.path = methodPath
        components.queryItems = [
            
            URLQueryItem(name: "api_key", value: "83a063f0-57f1-448a-9af6-d01dfe2d6293")
        ]
        components.queryItems?.append(contentsOf: queryItems ?? [])
        return components.url!
    }
}
