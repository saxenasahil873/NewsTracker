//
//  HeaderView.swift
//  NewsTracker
//
//  Created by Sahil Saxena on 17/04/24.
//

import Foundation
import UIKit

class HeaderView: UIView {
    private let headline: UILabel = {
       let label = UILabel()
        label.text = "HEADLINES"
        label.textColor = .white
        label.font = UIFont(name: "Rockwell-Regular", size: 29)
        label.backgroundColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubview(headline)
            
            // Add constraints for headline
            NSLayoutConstraint.activate([
                headline.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                headline.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                headline.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                headline.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
            ])
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
