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

    init(with json: JSON, formatter: DateConvertable.Type = DateConverter.self) {
        self.sourceName = json["source"]["name"].stringValue
        self.title = json["title"].stringValue
        self.postURL = json["url"].stringValue
        self.postImageURL = json["urlToImage"].stringValue
        self.date = formatter.getDateFormat(from: json["publishedAt"].stringValue)
    }
}

extension PostModel: Equatable {
    
    static func > (lhs: PostModel, rhs: PostModel) -> Bool {
        return lhs.date > rhs.date
    }
    
    static func < (lhs: PostModel, rhs: PostModel) -> Bool {
        return lhs.date < rhs.date
    }
}

