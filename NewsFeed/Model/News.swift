//
//  News.swift
//  NewsFeed
//
//  Created by Laasya Priya vemuri on 9/14/26.
//

import Foundation

// MARK: - News Response Model

nonisolated struct NewsResponse: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article Model

nonisolated struct Article: Decodable {
    let title: String
    let description: String?
    let urlToImage: String?
    let publishedAt: String
}
