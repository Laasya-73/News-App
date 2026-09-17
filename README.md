# News App

An iOS News application built with **Swift** and **UIKit** using **MVVM architecture** and **Dependency Injection**. The app fetches news from a REST API, displays articles in a table view, supports search, and uses image caching for better performance.

## Demo

<p align="center">
  <img src="Demo/news-app-demo.gif" width="320" alt="News App Demo">
</p>

## Features

- Fetches news articles from a REST API
- Displays articles using `UITableView`
- Search articles by title
- Asynchronous networking using `URLSession`
- JSON parsing using `Decodable`
- Image downloading and caching using `NSCache`
- Reusable custom table view cells
- Programmatic UI with Auto Layout
- MVVM architecture
- Dependency Injection
- Error handling using `Result`
- Unit testing using XCTest

## Architecture

The project follows the **MVVM architecture** to separate UI, presentation logic, and networking responsibilities.

```text
View
  ↓
ViewModel
  ↓
Network Service
  ↓
REST API
```

Dependency Injection is used to provide required services to the ViewModel instead of creating dependencies directly inside it.

## Tech Stack

- Swift
- UIKit
- MVVM
- Dependency Injection
- URLSession
- REST API
- Decodable
- NSCache
- UITableView
- Auto Layout
- XCTest

## Project Structure

```text
NewsFeed
├── Model
├── View
├── ViewModel
├── Network
├── Extensions
├── Constants
└── Tests
```

## Networking

The app uses `URLSession` for API communication and `Result` for handling success and failure responses.

Images are downloaded asynchronously and cached using `NSCache`, reducing repeated network requests when table view cells are reused.

## Search

The app supports case-insensitive search across loaded news articles. Clearing the search text automatically restores the complete list of articles.

## Testing

Unit tests are written using **XCTest** for important functionality such as:

- Valid search results
- Case-insensitive search
- Empty search text
- No matching articles
- Clearing search results
- ViewModel behavior

## Getting Started

1. Clone the repository:

```bash
git clone https://github.com/Laasya-73/News-App.git
```

2. Open `NewsFeed.xcodeproj` in Xcode.
3. Select an iOS Simulator or connected device.
4. Build and run the application.

## Requirements

- Xcode
- Swift
- iOS Simulator or physical iOS device

## Author

**Laasya Priya**

GitHub: [@Laasya-73](https://github.com/Laasya-73)
