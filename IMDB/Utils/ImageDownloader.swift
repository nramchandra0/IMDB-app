//
//  ImageDownloader.swift
//  IMDB
//
//  Created by Ramchandra on 24/09/23.
//

import UIKit

class ImageDownloader {

    private var cache = [String: UIImage]()

    // MARK: - Properties

    let responseQueue = DispatchQueue.main
    static let shared = ImageDownloader()

    private init() {}

    func downloadImage(for url: String, completion: @escaping (UIImage?) -> Void) {
        // Check if the image is already in the cache
        if let cachedImage = cache[url] {
            responseQueue.async {
                completion(cachedImage)
            }
            return
        }

        // If not in the cache, download it
        if let imageURL = URL(string: url) {
            URLSession.shared.dataTask(with: imageURL) { [weak self] (data, _, error) in
                if let error = error {
                    print("Error downloading image: \(error)")
                    self?.responseQueue.async {
                        completion(nil)
                    }
                    return
                }

                if let data = data, let image = UIImage(data: data) {
                    self?.cache[url] = image
                    self?.responseQueue.async {
                        completion(image)
                    }
                } else {
                    self?.responseQueue.async {
                        completion(nil)
                    }
                }
            }.resume()
        }
    }
}
