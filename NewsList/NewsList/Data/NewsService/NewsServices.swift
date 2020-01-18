//
//  NewsServices.swift
//  NewsList
//
//  Created by Andrew on 13/01/2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire


class NewsServices {
    
    static let custom: Session = {
        let config = URLSessionConfiguration.default
        config.headers = .default
        config.timeoutIntervalForRequest = 20
        let manager = Alamofire.Session(configuration: config)
        return manager
    }()
    
    public func getNews(page: Int, completion: @escaping ([PostModel]) -> ()) {
        
        let params: Parameters = [
            "country" : "ru",
            "apiKey" : Constants.apiKey,
            "page" : page,
            "pageSize" : Constants.pageSize
        ]
        
        let url = Constants.requestURL
        
        NewsServices.custom.request(url, method: .get, parameters: params).responseJSON { (response) in
        switch response.result {
            case .success(let value):
                let json = JSON(value)
                let news = self.handleParsing(from: json)
                completion(news)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func handleParsing(from json: JSON) -> [PostModel] {
        var newsArray: [PostModel] = []
        let articles = json["articles"]
        articles.arrayValue.forEach {  (post) in
            let post = PostModel(with: post)
            newsArray.append(post)
        }
        newsArray.sort { $0 > $1 }
        return newsArray
    }
}
