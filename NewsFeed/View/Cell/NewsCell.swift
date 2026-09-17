//
//  NewsCell.swift
//  NewsFeed
//
//  Created by Laasya Priya vemuri on 9/14/26.
//

import UIKit

class NewsCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = NewsConstants.newsCellIdentifier.rawValue
    
    var articleURL: String?

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .systemBlue
        label.numberOfLines = 0
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .label
        label.numberOfLines = 4
        return label
    }()

    let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.backgroundColor = .systemGray6
        return imageView
    }()

    let shareImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: NewsConstants.shareImageLabel.rawValue)
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .black
        return label
    }()

    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - User Defined Methods
    
    func setupUI() {
        selectionStyle = .none
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(newsImageView)
        contentView.addSubview(shareImageView)
        contentView.addSubview(dateLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant: -12),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant: -12),

            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            newsImageView.widthAnchor.constraint(equalToConstant: 150),
            newsImageView.heightAnchor.constraint(equalToConstant: 125),

            shareImageView.topAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.bottomAnchor, constant: 10),
            shareImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            shareImageView.widthAnchor.constraint(equalToConstant: 24),
            shareImageView.heightAnchor.constraint(equalToConstant: 24),

            dateLabel.centerYAnchor.constraint(equalTo: shareImageView.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: shareImageView.trailingAnchor, constant: 18),
            dateLabel.trailingAnchor.constraint(lessThanOrEqualTo: newsImageView.leadingAnchor,constant: -10),

            shareImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14),
            newsImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12)
        ])
    }
}

// MARK: - Helper Methods

extension NewsCell {
    func configure(with article: Article) {
        titleLabel.text = article.title
        descriptionLabel.text = article.description ?? article.title
        let fetchedDateText = article.publishedAt
        dateLabel.text = fetchedDateText.formatDate()
        newsImageView.downloadImage(from: article.urlToImage)
    }
}
