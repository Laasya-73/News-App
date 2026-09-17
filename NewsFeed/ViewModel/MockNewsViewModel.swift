//
//  MockNewsViewModel.swift
//  NewsFeed
//
//  Created by Laasya Priya vemuri on 9/16/26.
//

import Foundation

class MockNewsViewModel: NewsViewModelProtocol {

    // MARK: - Properties

    private var newsData: NewsResponse?
    
    private var filteredArticles: [Article] = []
        
    private var isSearching = false
        
    private var displayedArticles: [Article] {
        if isSearching {
            return filteredArticles
        }
        return newsData?.articles ?? []
    }

    // MARK: - Fetch Mock Data

    func fetchNewsFromNetwork(completion: @escaping () -> Void) {
        let mockArticle = Article(title: "Apple Announces New iPhone", description: "Apple has announced its latest iPhone with new features.", urlToImage: nil, publishedAt: "2026-09-16T10:00:00Z"
        )
        let fetchedNews = NewsResponse(status: "ok", totalResults: 1, articles: [mockArticle])
        newsData = fetchedNews
        completion()
    }

    // MARK: - Helper Functions

    func getArticlesCount() -> Int {
        displayedArticles.count
    }

    func displayArticles(for index: Int) -> Article? {
        guard index >= 0, index < displayedArticles.count else {
            return nil
        }
        return displayedArticles[index]
    }
    
    func searchArticles(with searchText: String) {
        let trimmedText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else {
            clearSearch()
            return
        }
        
        isSearching = true
        let articles = newsData?.articles ?? []
        filteredArticles = articles.filter { article in
            article.title.localizedCaseInsensitiveContains(trimmedText)
        }
    }
    
    func clearSearch() {
        isSearching = false
        filteredArticles.removeAll()
    }
}
