//
//  NewsFeedViewController.swift
//  NewsTracker
//
//  Created by Sahil Saxena on 17/04/24.
//

import UIKit

class NewsFeedViewController: UIViewController {
    
    var selectedArticle: Article?
    
    private let posterView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Rockwell-Regular", size: 24)
        return label
    }()
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Rockwell-Regular", size: UIFont.labelFontSize)
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Rockwell-Regular", size: UIFont.labelFontSize)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Rockwell-Regular", size: UIFont.labelFontSize)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark //setting default dark mode
        
        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = true
        backBarButton()
        
        setData()
    }
    
    private func backBarButton(){
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        backButton.tintColor = .white
        // Set the back button item for the navigation item
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backButtonTapped() {
        // Handle back button tap action
        navigationController?.popViewController(animated: true)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(posterView)
        view.addSubview(titleLabel)
        view.addSubview(brandLabel)
        view.addSubview(dateLabel)
        view.addSubview(descriptionLabel)
        posterView.frame = view.bounds
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            titleLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 200),
            
            brandLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            brandLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            brandLabel.widthAnchor.constraint(equalToConstant: 200),
            brandLabel.heightAnchor.constraint(equalToConstant: 50),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            dateLabel.widthAnchor.constraint(equalToConstant: 100),
            dateLabel.heightAnchor.constraint(equalToConstant: 50),
            
            descriptionLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            descriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
        
    }
    
    private func setData() {
        if let urlString = selectedArticle?.urlToImage, let url = URL(string: urlString) {
            // Load image from URL using SDWebImage
            posterView.sd_setImage(with: url, completed: nil)
        }
        
        titleLabel.text = selectedArticle?.title
        brandLabel.text = selectedArticle?.source.name
        let date = selectedArticle?.publishedAt
        let stringValue = date
        let substring = String(stringValue!.prefix(10)) // Get the first YYYY-MM-DD characters
        dateLabel.text = substring
        descriptionLabel.text = selectedArticle?.description
    }
    
}
