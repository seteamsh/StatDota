import Foundation
import SwiftUI

final class ImageLoader: ObservableObject {
    init () {}
    static let shared = ImageLoader()
    
    func loadImage(imageURL: String) {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            if let data = try? Data(contentsOf: URL(string: imageURL)!) {
                let uiImage = UIImage(data: data)
            }
            
        }
    }
}
