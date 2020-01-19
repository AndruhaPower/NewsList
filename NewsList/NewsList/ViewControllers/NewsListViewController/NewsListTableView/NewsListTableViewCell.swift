//
//  NewsListTableViewCell.swift
//  NewsList
//
//  Created by Andrew on 13/01/2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {
    
    static let reuseId: String = "feedCell"
    var indexPath: IndexPath?
    
    var sourceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        return label
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 14)
        return label
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "STHeitiTC-Light", size: 14)
        return label
    }()
    
    var postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.postImage.image = nil
    }
    
    private func setupView() {
        
        let width = self.contentView.frame.size.width
        let screenWidth = UIScreen.main.bounds.size.width
        
        self.contentView.addSubview(self.sourceLabel)
        
        self.sourceLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: width * 0.05).isActive = true
        self.sourceLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        
        self.contentView.addSubview(self.dateLabel)
        
        self.dateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: width * 0.05).isActive = true
        self.dateLabel.topAnchor.constraint(equalTo: self.sourceLabel.bottomAnchor, constant: 10).isActive = true
        
        self.contentView.addSubview(self.titleLabel)
        
        self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: width * 0.05).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 15).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -width * 0.05).isActive = true
        self.titleLabel.numberOfLines = 2
        
        self.addSubview(self.postImage)
        
        self.postImage.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 15).isActive = true
        self.postImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: width * 0.05).isActive = true
        self.postImage.widthAnchor.constraint(equalToConstant: screenWidth * 0.9).isActive = true
        self.postImage.heightAnchor.constraint(equalToConstant: width * 0.7).isActive = true
    }
}
