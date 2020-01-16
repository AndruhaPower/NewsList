//
//  WebView.swift
//  NewsList
//
//  Created by Andrew on 14/01/2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    let url: String
    
    override func viewDidLoad() {
        self.setupWebView()
    }
    
    init(with url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupWebView() {
        let webView = WKWebView()
        guard let url = URL(string: self.url) else { return }
        webView.load(URLRequest(url: url))
        self.view = webView
    }
}

