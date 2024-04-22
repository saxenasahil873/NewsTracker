//
//  File.swift
//  NewsTracker
//
//  Created by Sahil Saxena on 15/09/23.
//

import UIKit
import SDWebImage

class NewsDataTableViewCell: UITableViewCell {
    
    static let identifier = "NewsDataTableViewCell"
    
    private let posterView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.backgroundColor = .black
        return image
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.font = UIFont(name: "Rockwell-Regular", size: 20)
        return label
    }()
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Rockwell-Bold", size: UIFont.labelFontSize)
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Rockwell-Regular", size: 10)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemGray3
        contentView.addSubview(posterView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(brandLabel)
        contentView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            posterView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            posterView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            posterView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            posterView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 140),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60),
            
            brandLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            brandLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            brandLabel.widthAnchor.constraint(equalToConstant: 80),
            brandLabel.heightAnchor.constraint(equalToConstant: 15),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: brandLabel.trailingAnchor, constant: 10),
            dateLabel.widthAnchor.constraint(equalToConstant: 80),
            dateLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    public func configure(with article: Article) {
        // Save the array of articles
        if let urlString = article.urlToImage, let url = URL(string: urlString) {
            // Load image from URL using SDWebImage
            posterView.sd_setImage(with: url, completed: nil)
        }
        
        titleLabel.text = article.title
        
        brandLabel.text = article.source.name
        
        let date = article.publishedAt
        let stringValue = date
        let substring = String(stringValue.prefix(10)) // Get the first YYYY-MM-DD characters
        dateLabel.text = substring
    }
    
    
    
}


