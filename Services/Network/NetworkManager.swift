import Foundation

final class NetworkManager: ObservableObject {
    init () {}
    static let shared = NetworkManager()
    
    func fetchProfile(id: Int, completion: @escaping (Result<Profile, NetworkError>) -> Void)  {
        let url = URL(string: "https://api.opendota.com/api/players/\(id)?api_key=83a063f0-57f1-448a-9af6-d01dfe2d6293")!
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
                        print(safeData)
                        completion(.success(decodedProfile.profile))
                    } catch {
                        completion(.failure(.decodingError))
                    }
                }
            }
        }.resume()
    }
    func fetchWinLose(id: Int, gameMode: GameMode, completion: @escaping (Result<WinLose, NetworkError>) -> Void) {
        let url = URL(string: "https://api.opendota.com/api/players/\(id)/wl\(gameMode.mode)")!
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
        let url = URL(string: "https://api.opendota.com/api/players/\(id)/heroes\(gameMode.mode)")!
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
    func fetchPlayerMatches(id: Int, gameMode: GameMode, offset: Int = 0, completion: @escaping (Result<[PlayerMatches], NetworkError>) -> Void) {
        let url = URL(string: "https://api.opendota.com/api/players/\(id)/matches\(gameMode.findMatches)&offset=\(offset)")!
        
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
}
