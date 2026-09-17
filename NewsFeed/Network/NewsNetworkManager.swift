//
//  NewsNetworkManager.swift
//  NewsFeed
//
//  Created by Laasya Priya vemuri on 9/14/26.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchNewsData(serverUrl: String, completion: @escaping (Result<NewsResponse, ErrorType>) -> Void)
}

class NewsNetworkManager: NetworkManagerProtocol {
    
    // MARK: - Property
    
    static let shared = NewsNetworkManager()

    // MARK: - Initializer
    
    private init() { }

    // MARK: - User Defined Methods
    
    func fetchNewsData(serverUrl: String, completion: @escaping (Result<NewsResponse, ErrorType>) -> Void) {
        guard let serverURL = URL(string: serverUrl) else {
            completion(.failure(.invalidURL))
            return
        }

        let request = URLRequest(url: serverURL)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.networkError))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.networkError))
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.badServerResponse(statusCode: httpResponse.statusCode)))
                return
            }

            guard let jsonData = data else {
                completion(.failure(.networkError))
                return
            }

            do {
                let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: jsonData)
                completion(.success(newsResponse))
            } catch {
                //print("Log:: Decoding failed \(error.localizedDescription)")
                completion(.failure(.decodingFailed))
            }
        }.resume()
    }
}
