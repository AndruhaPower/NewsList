//
//  NewsListViewController.swift
//  NewsList
//
//  Created by Andrew on 13/01/2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit

class NewsListViewController: UIViewController {
    
    var feedTableView = NewsListTableView()
    let newsServices = NewsServices()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.feedTableView.tableViewPushDelegate = self
        self.view = self.feedTableView
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Новости"
        newsServices.getNews { (news) in
            self.feedTableView.news = news
            DispatchQueue.main.async {
                self.feedTableView.reloadData()
            }
        }
        
    }
}

extension NewsListViewController: TableViewPushDelegate {
    
    func pushVC(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

