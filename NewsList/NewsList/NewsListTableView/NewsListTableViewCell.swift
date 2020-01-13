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
    
    var sourceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "STHeitiTC-Light", size: 14)
        return label
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "STHeitiTC-Light", size: 14)
        return label
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "STHeitiTC-Light", size: 14)
        return label
    }()
    
    var feedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
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
        self.feedImage.image = nil
    }
    
    private func setupView() {
        
        let width = UIScreen.main.bounds.size.width
        
        self.addSubview(self.sourceLabel)
        
        self.sourceLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: width * 0.05).isActive = true
        self.sourceLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15).isActive = true //test
        self.sourceLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor).isActive = true

        self.addSubview(self.dateLabel)
        
        self.dateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: width * 0.05).isActive = true
        self.dateLabel.topAnchor.constraint(equalTo: self.sourceLabel.bottomAnchor, constant: 10).isActive = true
        self.dateLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor).isActive = true
        
        self.addSubview(self.titleLabel)
        
        self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: width * 0.05).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 15).isActive = true
        self.titleLabel.widthAnchor.constraint(equalToConstant: width - (width * 0.05)).isActive = true
        
        self.titleLabel.numberOfLines = 0
        
        self.addSubview(self.feedImage)
        self.feedImage.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 15).isActive = true
        self.feedImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: width * 0.05).isActive = true
        self.feedImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -width * 0.05).isActive = true
        self.feedImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 15).isActive = true
    }
}
