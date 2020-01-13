//
//  NewsListTableView.swift
//  NewsList
//
//  Created by Andrew on 13/01/2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit


class NewsListTableView: UITableView {
    
    var news: [String] = ["TEST", "TEST2", "TEST3", "TEST4", "TEST5", "TEST6"]
    var testTITLE = "Today i took a really big job on my shoulders. Cant wait to Get to work"
    
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
    
//    private func getHeightForMediaCell(indexPath: IndexPath) -> CGFloat {
//        let tableWidth = self.bounds.width
//        let news = self.news[indexPath.row]
//    var cellHeight: CGFloat = 150
//    if news.attachments.count == nil {
//        return cellHeight }
//    else if
//    }
}

extension NewsListTableView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: NewsListTableViewCell.reuseId, for: indexPath) as? NewsListTableViewCell else { return UITableViewCell() }
        cell.sourceLabel.text = self.news[indexPath.row]
        cell.dateLabel.text = self.news[indexPath.row]
        cell.titleLabel.text = self.testTITLE
        let image = UIImage(named: "testphoto")
        cell.feedImage.image = image
        
        return cell
    }
}

extension NewsListTableView {
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func downloadImage(from url: URL) -> UIImage {
        var escapeData: Data = Data()
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            escapeData = data
        }
        guard let image = UIImage(data: escapeData) else { return UIImage() }
        return image
    }
}
