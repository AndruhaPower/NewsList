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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
         self.view.backgroundColor = .white
         self.navigationController?.navigationBar.prefersLargeTitles = true
         self.title = "Новости"
        // Do any additional setup after loading the view.
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.view = self.feedTableView
    }


}

