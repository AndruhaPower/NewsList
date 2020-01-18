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

final class NewsListTableView: UITableView {
    
    public weak var tableViewPushDelegate: TableViewPushDelegate?
    
    var page: Int = 1
    var news = [PostModel]()
    
    let operationQueue = OperationQueue()
    var cachedImages = [String : UIImage]()
    var newsServices = NewsServices()
    
    var isLoading: Bool = false
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.setupTableView()
        self.configRefreshControl()
        self.getNews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: setting up TableView
    
    private func setupTableView() {
        self.backgroundColor = .white
        self.delegate = self
        self.dataSource = self
        self.prefetchDataSource = self
        self.register(NewsListTableViewCell.self, forCellReuseIdentifier: NewsListTableViewCell.reuseId)
    }

    private func setPicture(for cell: NewsListTableViewCell, at indexPath: IndexPath) {
        
        let post = self.news[indexPath.row]
        
        if self.cachedImages[post.date] != nil {
            cell.postImage.image = self.cachedImages[post.date]
        } else {
            let operation = LoadImageOperation()
            operation.url = URL(string: post.postImageURL)
            self.operationQueue.addOperation(operation)
            operation.completion = { [weak self] (image) in
                guard let self = self else { return }
                if cell.indexPath == indexPath {
                    self.cachedImages[post.date] = image
                    cell.postImage.image = image
                }
            }
        }
    }
    
    private func getNews() {
        self.newsServices.getNews(page: self.page) { [weak self] (news) in
            guard let self = self else { return }
            self.news = news
            self.reloadData()
        }
    }
    
    private func configRefreshControl() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Обновление...")
        self.refreshControl?.tintColor = .darkGray
        self.refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
    }
    
    @objc func refreshNews(_ sender: Any) {
        self.newsServices.getNews(page: 1) { [weak self] (response) in
            guard let self = self else { return }
            var newPosts = response
            guard let currentTopDate = self.news.first?.date else { self.getNews(); return }
            newPosts.removeAll { $0.date <= currentTopDate }
            self.news = newPosts + self.news
            self.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
}

// MARK: Extensions

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
        guard let cell = dequeueReusableCell(withIdentifier: NewsListTableViewCell.reuseId, for: indexPath) as?
            NewsListTableViewCell, indexPath.row < self.news.count else { return UITableViewCell() }
        cell.sourceLabel.text = self.news[indexPath.row].sourceName
        cell.dateLabel.text = self.news[indexPath.row].date
        cell.titleLabel.text = self.news[indexPath.row].title
        cell.indexPath = indexPath
        self.setPicture(for: cell, at: indexPath)
        
        return cell
    }
}

// MARK: EndlessScroll

extension NewsListTableView: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxRow =  indexPaths.map({ $0.row }).max()
            , maxRow > self.news.count - 3 else { return }

            if !self.isLoading {
            self.isLoading = true
            self.page = Int(self.news.count / Constants.pageSize) + 1
            
            self.newsServices.getNews(page: self.page) { [weak self] (olderPosts) in
                guard let self = self
                    , olderPosts.count != 0
                    , let firstPost = olderPosts.first
                    , let lastPost = self.news.last
                    , lastPost > firstPost else { return }
                self.news.append(contentsOf: olderPosts)
                self.reloadData()
                self.isLoading = false
            }
        }
    }
}
