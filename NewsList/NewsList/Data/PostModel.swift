//
//  PostModel.swift
//  NewsList
//
//  Created by Andrew on 13/01/2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit
import SwiftyJSON

struct PostModel {
    
    var sourceName: String
    var title: String
    var postURL: String
    var postImageURL: String
    var date: String

    init(with json: JSON) {
        self.sourceName = json["source"]["name"].stringValue
        self.title = json["title"].stringValue
        self.postURL = json["url"].stringValue
        self.postImageURL = json["urlToImage"].stringValue
        self.date = json["publishedAt"].stringValue
    }
}

