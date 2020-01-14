//
//  MainWebView.swift
//  NewsList
//
//  Created by Andrew on 14/01/2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit
import WebKit
 
class MainWebView: WKWebView {


    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(with url: String) {
        self.translatesAutoresizingMaskIntoConstraints = false
        guard let url = URL(string: url) else { return }
        self.load(URLRequest(url: url))
    }
}
