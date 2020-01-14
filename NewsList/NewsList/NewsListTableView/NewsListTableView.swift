//
//  NewsListTableView.swift
//  NewsList
//
//  Created by Andrew on 13/01/2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit

protocol TableViewPushDelegate: class {
    func pushVC(viewController: UIViewController)
}


class NewsListTableView: UITableView {
    
    public weak var tableViewPushDelegate: TableViewPushDelegate?
    
    var news: [PostModel] = []
    let operationQueue = OperationQueue()
    var cachedImages: [IndexPath : UIImage] = [:]
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        self.backgroundColor = .white
        self.delegate = self
        self.dataSource = self
        self.register(NewsListTableViewCell.self, forCellReuseIdentifier: NewsListTableViewCell.reuseId)

    }
    
    private func setPicture(for cell: NewsListTableViewCell, at indexPath: IndexPath) {
        
        guard self.cachedImages[indexPath] == nil else {
            return cell.postImage.image = cachedImages[indexPath]
        }
        
        let operation = LoadImageOperation()
        operation.url = URL(string: self.news[indexPath.row].postImageURL)
        self.operationQueue.addOperation(operation)
        operation.completion = { image in
            if cell.indexPath == indexPath {
                self.cachedImages[indexPath] = image
                cell.postImage.image = image
            } else { cell.frame = .zero }
        }
    }
}

extension NewsListTableView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = self.news[indexPath.row].postURL
        let vc = WebViewController(with: url)
        self.tableViewPushDelegate?.pushVC(viewController: vc)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: NewsListTableViewCell.reuseId, for: indexPath) as? NewsListTableViewCell else { return UITableViewCell() }
        cell.sourceLabel.text = self.news[indexPath.row].sourceName
        cell.dateLabel.text = self.news[indexPath.row].date
        cell.titleLabel.text = self.news[indexPath.row].title
        cell.indexPath = indexPath
        self.setPicture(for: cell, at: indexPath)
        
        return cell
    }
}
