//
//  Extension.swift
//  NewsFeed
//
//  Created by Laasya Priya vemuri on 9/14/26.
//

import UIKit

extension UIImageView {
    func downloadImage(from imageURLString: String?) {
        self.image = UIImage(systemName: NewsConstants.defaultImagePlaceholder.rawValue)
        guard let imageURLString = imageURLString, let imageURL = URL(string: imageURLString) else {
            return
        }

        ImageManager.shared.fetchImage(for: imageURL) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.image = image
                }
            case .failure(let error):
                print("Log:: Image error \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.image = UIImage(systemName: NewsConstants.defaultImagePlaceholder.rawValue)
                }
            }
        }
    }
}

extension String {
    func formatDate() -> String {
        let inputFormatter = ISO8601DateFormatter()
        guard let date = inputFormatter.date(from: self) else {
            return self
        }

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMM dd, yyyy"
        return outputFormatter.string(from: date)
    }
}
