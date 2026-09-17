//
//  ViewController.swift
//  NewsFeed
//
//  Created by Laasya Priya vemuri on 9/14/26.
//

import UIKit

class NewsViewController: UIViewController {
    
    // MARK: - Properties
    
    let viewModel: NewsViewModelProtocol
    
    init(viewModel: NewsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = NewsConstants.searchPlaceholder.rawValue
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .systemGray5
        searchBar.searchTextField.layer.cornerRadius = 12
        searchBar.searchTextField.clipsToBounds = true
        return searchBar
    }()
    
    let newsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 180
        return tableView
    }()
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NewsConstants.screenTitle.rawValue
        self.view.backgroundColor = .systemBackground
        setupUI()
        setupConstraints()
        fetchNewsData()
    }
    
    // MARK: - User Defined Methods
    
    func setupUI() {
        searchBar.delegate = self
        view.addSubview(searchBar)
        
        newsTableView.dataSource = self
        newsTableView.delegate = self
        newsTableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        view.addSubview(newsTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 1),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            newsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 4),
            newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func fetchNewsData() {
        viewModel.fetchNewsFromNetwork { [weak self] in
            DispatchQueue.main.async() {
                self?.newsTableView.reloadData()
            }
        }
    }
}

// MARK: - UITableView Data Source Methods

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getArticlesCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell else {
            return UITableViewCell()
        }
        guard let article = viewModel.displayArticles(for: indexPath.row) else {
            return cell
        }
        cell.configure(with: article)
        return cell
    }
}

// MARK: - UITableView Delegate Methods

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UISearchBar Delegate Methods

extension NewsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchArticles(with: searchText)
        newsTableView.reloadData()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.clearSearch()
        newsTableView.reloadData()
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
}

