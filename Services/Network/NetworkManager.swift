import Foundation

final class NetworkManager: ObservableObject {
    init () {}
    static let shared = NetworkManager()
    
    func fetchProfile(id: Int, completion: @escaping (Result<Profile, NetworkError>) -> Void)  {
        guard let url = OpenDotaAPI.profile(id: id).url else {
            return completion(.failure(.badURL))
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                return completion(.failure(.noData))
            } else {
                let httpResponse = response as? HTTPURLResponse
                if httpResponse?.statusCode == 404 {
                    completion(.failure(.notFoundPlayerID))
                } else {
                    guard let safeData = data else {
                        return completion(.failure(.noData))
                    }
                    do {
                        let decodedProfile = try JSONDecoder().decode(Wrapper.self, from: safeData)
                        completion(.success(decodedProfile.profile))
                    } catch {
                        completion(.failure(.decodingError))
                    }
                }
            }
        }.resume()
    }
    func fetchWinLose(id: Int, gameMode: GameMode, completion: @escaping (Result<WinLose, NetworkError>) -> Void) {
        guard let url = OpenDotaAPI.totalMatches(id: id, gameMode: gameMode, path: "wl").url else {
             return completion(.failure(.badURL))
        }
        print(url)
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                return completion(.failure(.noData))
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse?.statusCode ?? "")
                guard let safeData = data else {
                    return completion(.failure(.noData))
                }
                do {
                    let winLose = try JSONDecoder().decode(WinLose.self, from: safeData)
                    completion(.success(winLose))
                } catch {
                    completion(.failure(.decodingError))
                }
                
            }
        }.resume()
    }
    func fetchHeroes(completion: @escaping (Result<[Hero], NetworkError>) -> Void) {
        let url = URL(string: "https://api.opendota.com/api/heroes")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.noData))
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return completion(.failure(.badResponse))
            }
            guard let safeData = data else {
                return completion(.failure(.noData))
            }
            do {
                let decodedData = try JSONDecoder().decode([Hero].self, from: safeData)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    func fetchPlayerHeroes(id: Int, gameMode: GameMode, completion: @escaping (Result<[PlayerHeroes], NetworkError>) -> Void) {
        guard let url = OpenDotaAPI.totalMatches(id: id, gameMode: gameMode, path: "heroes").url else {
             return completion(.failure(.badURL))
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.noData))
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return completion(.failure(.badResponse))
            }
            guard let safeData = data else {
                return completion(.failure(.noData))
            }
            do {
                let decodedData = try JSONDecoder().decode([PlayerHeroes].self, from: safeData)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))

            }
        }.resume()
    }
    func fetchPlayerMatches(id: Int, gameMode: GameMode, offset: Int,
                            limit: Int, completion: @escaping (Result<[PlayerMatches], NetworkError>) -> Void) {
        guard let url = OpenDotaAPI.playerMatches(id: id, gameMode: gameMode, offset: offset, limit: limit).url else {
            return completion(.failure(.badURL))
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.noData))
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return completion(.failure(.badResponse))
            }
            guard let safeData = data else {
                return completion(.failure(.noData))
            }
            do {
                let decodedData = try JSONDecoder().decode([PlayerMatches].self, from: safeData)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    enum OpenDotaAPI {
        case profile(id: Int)
        case totalMatches(id: Int, gameMode: GameMode, path: String)
        case playerMatches(id: Int, gameMode: GameMode, offset: Int, limit: Int)

        var url: URL? {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.opendota.com"
            
            var queryItems = [URLQueryItem(name: "api_key", value: "83a063f0-57f1-448a-9af6-d01dfe2d6293")]
            
            switch self {
                case .profile(let id):
                components.path = "/api/players/\(id)/"
                
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
