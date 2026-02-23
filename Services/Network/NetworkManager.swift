import Foundation

final class NetworkManager: ObservableObject {
    init () {}
    static let shared = NetworkManager()
    
    func performRequest<T: Decodable>(url: OpenDotaAPI, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = url.url else {
            return completion(.failure(.badURL))
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error as NSError? {
                if error.code == NSURLErrorNotConnectedToInternet {
                    return completion(.failure(.offline))
                } else if error.code == NSURLErrorTimedOut {
                    return completion(.failure(.timeout))
                }
                return completion(.failure(.unknown(error)))
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.failure(.noData))
            }
            if httpResponse.statusCode == 404 {
                completion(.failure(.notFoundedPlayerID))
            }
            if !(200...299).contains(httpResponse.statusCode) {
                return completion(.failure(.badResponse(statusCode: httpResponse.statusCode)))
            }
            guard let safeData = data else {
                return completion(.failure(.noData))
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: safeData)
                completion(.success(decodedData))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(.decodingError))
            }
        }.resume()
    }    
    
    enum OpenDotaAPI {
        case totalMatches(id: Int, gameMode: GameMode, path: String)
        case playerMatches(id: Int, gameMode: GameMode, offset: Int, limit: Int)
        
        var url: URL? {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.opendota.com"
            
            var queryItems = [URLQueryItem(name: "api_key", value: "83a063f0-57f1-448a-9af6-d01dfe2d6293")]
            
            switch self {
                
            case .totalMatches(let id, let gameMode, let path):
                components.path = "/api/players/\(id)/\(path)"
                if gameMode != .allPick {
                    queryItems.append(URLQueryItem(name: "game_mode", value: "23"))
                    queryItems.append(URLQueryItem(name: "significant", value: "0"))
                }
                
            case .playerMatches(let id, let gameMode, let offset, let limit):
                components.path = "/api/players/\(id)/matches"
                
                queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"))
                queryItems.append(URLQueryItem(name: "offset", value: "\(offset)"))
                if gameMode != .allPick {
                    queryItems.append(URLQueryItem(name: "game_mode", value: "23"))
                    queryItems.append(URLQueryItem(name: "significant", value: "0"))
                }
                components.queryItems = queryItems
                
            }
            return components.url
        }
    }
}
