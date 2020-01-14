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
    
    public func getNews(completion: @escaping ([PostModel]) -> ()) {
        
        let url = Constants.requestURL
        
        NewsServices.custom.request(url, method: .get).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                var newsArray: [PostModel] = []
                let json = JSON(value)
                let articles = json["articles"]
                articles.arrayValue.forEach {  (post) in
                    let post = PostModel(with: post)
                    newsArray.append(post)
                }
                completion(newsArray)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
