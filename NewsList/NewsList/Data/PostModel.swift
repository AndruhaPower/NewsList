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
        self.date = getDateFormat(from: self.date)
    }
    
    private func getDateFormat(from string: String) -> String {
        
        let dateFormatterGetter = DateFormatter()
        dateFormatterGetter.dateFormat = "YYYY-M-DD'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.locale = Locale(identifier: "ru_RU")
        dateFormatterPrint.dateFormat = "dd.MM.yyyy HH:mm"
        
        var exitString = ""
        
        if let date = dateFormatterGetter.date(from: string) {
            exitString = dateFormatterPrint.string(from: date)
        }
        return exitString
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

