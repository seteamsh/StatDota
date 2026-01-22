import Foundation

final class NetworkManager: ObservableObject {
    init () {}
    static let shared = NetworkManager()
    
    func fetchProfile(id: Int, completion: @escaping (Result<Profile, NetworkError>) -> Void)  {
        performRequest(url: .profile(id: id)) { (result: Result<Wrapper, NetworkError>) in
            switch result {
            case .success(let wrapper):
                completion(.success(wrapper.profile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func fetchWinLose(id: Int, gameMode: GameMode, completion: @escaping (Result<WinLose, NetworkError>) -> Void) {
        performRequest(url: .totalMatches(id: id, gameMode: gameMode, path: "wl"), completion: completion)
    }
    func fetchHeroes(completion: @escaping (Result<[Hero], NetworkError>) -> Void) {
        performRequest(url: .heroes, completion: completion)
    }
    func fetchPlayerHeroes(id: Int, gameMode: GameMode, completion: @escaping (Result<[PlayerHeroes], NetworkError>) -> Void) {
        performRequest(url: .totalMatches(id: id, gameMode: gameMode, path: "heroes"),completion: completion)
    }
    
    func fetchPlayerMatches(id: Int, gameMode: GameMode, offset: Int,
                            limit: Int, completion: @escaping (Result<[PlayerMatches], NetworkError>) -> Void) {
        performRequest(url: .playerMatches(id: id, gameMode: gameMode, offset: offset, limit: limit), completion: completion)
    }
    
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
        case profile(id: Int)
        case totalMatches(id: Int, gameMode: GameMode, path: String)
        case playerMatches(id: Int, gameMode: GameMode, offset: Int, limit: Int)
        case heroes
        
        var url: URL? {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.opendota.com"
            
            var queryItems = [URLQueryItem(name: "api_key", value: "83a063f0-57f1-448a-9af6-d01dfe2d6293")]
            
            switch self {
            case .profile(let id):
                components.path = "/api/players/\(id)/"
                print(components.path)
                
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
            case .heroes:
                components.path = "/api/heroes"
            }
            components.queryItems = queryItems
            return components.url
        }
    }
    
    //    func fetchItems(completion: @escaping (Result<[Item], NetworkError>) -> Void) {
    //        let url = URL(string: "https://api.opendota.com/api/constants/items")!
    //        URLSession.shared.dataTask(with: url) { data, response, error in
    //            if error != nil {
    //                completion(.failure(.noData))
    //            }
    //            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
    //                completion(.failure(.badResponse))
    //                return
    //            }
    //            guard let safeData = data else {
    //                completion(.failure(.noData))
    //                return
    //            }
    //            do {
    //                let decodedData = try JSONDecoder().decode([Item].self, from: safeData)
    //            } catch {
    //                completion(.failure(.decodingError))
    //            }
    //
    //        }
    //    }
}
