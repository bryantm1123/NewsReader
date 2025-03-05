import UIKit

class ImageCache: NSCache<AnyObject, UIImage> {
    static let shared = ImageCache()
}
// inspired by: https://stackoverflow.com/a/52330296
extension UIImageView {
    func loadImage(from url: URL?) async throws {
        guard let url else { return }
        
        if let cached = ImageCache.shared.object(forKey: url as AnyObject) {
            image = cached
        } else {
            let (data, _) = try await URLSession.shared.data(from: url)
            await MainActor.run {
                guard let cachedImage = UIImage(data: data) else { return }
                ImageCache.shared.setObject(cachedImage, forKey: url as AnyObject)
                self.image = cachedImage
            }
        }
    }
}
