import Foundation

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    
    func decode(_ data: Data) throws -> ModelType
    func execute(withCompletion completion: @escaping (Result<ModelType?, NetworkError>) -> Void)
}

extension NetworkRequest {
    func load(_ url: URL, withCompletion completion: @escaping (Result<ModelType?, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, respone, error in
            if let error = error {
                return completion(.failure(.unknown(error)))
            }
            guard let data = data else {
                return completion(.failure(NetworkError.noData))
            }
            do {
                let value = try self.decode(data)
                completion(.success(value))
            } catch {
                completion(.failure(NetworkError.notFoundPlayerID))
            }
        }.resume()
    }
}
