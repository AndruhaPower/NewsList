//
//  DateConverter.swift
//  NewsList
//
//  Created by Andrew on 15/01/2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation

protocol DateConvertable {
    static func getDateFormat(from string: String) -> String
}

struct DateConverter: DateConvertable {

    static func getDateFormat(from string: String) -> String {
        
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

