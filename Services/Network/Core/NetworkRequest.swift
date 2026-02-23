import Foundation

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    
    func decode(_ data: Data) -> ModelType?
    func execute(withCompletion completion: @escaping (ModelType?) -> Void)
}

extension NetworkRequest {
    func load(_ url: URL, withCompletion completion: @escaping (ModelType?) -> Void) {
        URLSession.shared.dataTask(with: url) { ( data, _, _ ) in
            guard let data = data, let value = self.decode(data) else {
                return completion(nil)
            }
            print(url)
            print(value)
            
            completion(value)
        }.resume()
    }
}
