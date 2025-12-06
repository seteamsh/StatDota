import Foundation

final class NetworkManager: ObservableObject {
    init () {}
    static let shared = NetworkManager()
    
    func fetchProfile(id: Int, complietion: @escaping (Result<Profile, NetworkError>) -> Void)  {
        let url = URL(string: "https://api.opendota.com/api/players/\(id)?api_key=83a063f0-57f1-448a-9af6-d01dfe2d6293")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                return complietion(.failure(.noData))
            } else {
                let httpResponse = response as? HTTPURLResponse
                print("Status code: \(httpResponse?.statusCode ?? 0)")
                if httpResponse?.statusCode == 404 {
                    complietion(.failure(.notFoundPlayerID))
                } else {
                    guard let safeData = data else { return }
                    do {
                        let decodedProfile = try JSONDecoder().decode(Employee.self, from: safeData)
                        complietion(.success(decodedProfile.profile))
                        
                    } catch {
                        complietion(.failure(.decodingError))
                    }
                }
            }
        }.resume()
    }
}
