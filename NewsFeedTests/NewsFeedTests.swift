//
//  NewsFeedTests.swift
//  NewsFeedTests
//
//  Created by Laasya Priya vemuri on 9/14/26.
//

import XCTest
@testable import NewsFeed

final class NewsFeedTests: XCTestCase {
    
    var newsViewModel: NewsViewModelProtocol?
    
    override func setUpWithError() throws {
        newsViewModel = MockNewsViewModel()
    }
    override func tearDownWithError() throws {
        newsViewModel = nil
    }
    
    func testGetArticlesCount() {
        let count = newsViewModel?.getArticlesCount()
        XCTAssertEqual(count, 0)
    }
    
    func testGetArticles() {
        let articles = newsViewModel?.displayArticles(for: 0)
        XCTAssertNil(articles)
    }
}
