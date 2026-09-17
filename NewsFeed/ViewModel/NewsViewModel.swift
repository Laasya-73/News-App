//
//  NewsViewModel.swift
//  NewsFeed
//
//  Created by Laasya Priya vemuri on 9/16/26.
//

import Foundation

//MARK: - News ViewModel Protocol

protocol NewsViewModelProtocol {
    func fetchNewsFromNetwork(completion: @escaping () -> Void)
    func getArticlesCount() -> Int
    func displayArticles(for index: Int) -> Article?
    func searchArticles(with searchText: String)
    func clearSearch()
}

//MARK: - News ViewModel

class NewsViewModel: NewsViewModelProtocol {
    
    //MARK: - Properties
    
    private var newsData: NewsResponse?
    private let objNetwork: NetworkManagerProtocol
    
    private var filteredArticles: [Article] = []
    private var isSearching: Bool = false
    private var displayedArticles: [Article] {
         if isSearching {
             return filteredArticles
         }
         return newsData?.articles ?? []
     }
    
    //MARK: - Initializer
    
    init(objNetwork: NetworkManagerProtocol) {
        self.objNetwork = objNetwork
    }
    
    func fetchNewsFromNetwork(completion: @escaping () -> Void) {
        objNetwork.fetchNewsData(serverUrl: NewsConstants.newsURL.rawValue) { [weak self] fetchedNews in
            switch fetchedNews {
            case .success(let newsResponse):
                self?.newsData = newsResponse

            case .failure(let error):
                print("Failed to fetch news: \(error)")
            }
            completion()
        }
    }
    
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


/*
 NewsNetworkManager returns a Result containing either a successful NewsResponse or an ErrorType. Therefore, in the ViewModel I use a switch to handle .success and .failure. On success I extract the NewsResponse and store it in newsData; on failure I handle the error. After the network operation finishes, I call completion so the ViewController is notified.
 */
