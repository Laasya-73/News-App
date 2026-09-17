//
//  ImageManager.swift
//  NewsFeed
//
//  Created by Laasya Priya vemuri on 9/14/26.
//

import UIKit

class ImageManager {
    
    // MARK: - Properties
    
    static let shared = ImageManager()
    
    static let imageCache = NSCache<NSURL, UIImage>()

    // MARK: - Initializer
    
    private init() { }

    // MARK: - User Defined Method
    
    func fetchImage(for url: URL, completionHandler: @escaping (Result<UIImage, Error>) -> Void) {
        if let cachedImage = ImageManager.imageCache.object(forKey: url as NSURL) {
            //print("Log:: Image fetched from cache")
            completionHandler(.success(cachedImage))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }

            guard let imageData = data else {
                return
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
                guard let image = UIImage(data: imageData) else {
                    return
                }
                ImageManager.imageCache.setObject(image, forKey: url as NSURL)
                //print("Log:: Image fetched from server")
                completionHandler(.success(image))
            }
        } .resume()
    }
}
