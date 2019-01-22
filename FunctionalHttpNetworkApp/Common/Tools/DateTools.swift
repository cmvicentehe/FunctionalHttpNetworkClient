//
//  DateTools.swift
//  FunctionalHttpNetworkApp
//
//  Created by Carlos Vicente on 22/01/2019.
//  Copyright © 2019 cmvicentehe. All rights reserved.
//

import Foundation

struct DateTools {
    static func convertDateStringToServerDateFormat(_ date: String) -> Date? {
         #warning("TODO: Modify this format from server")
        let currentDateFormatter = DateFormatter()
        currentDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return currentDateFormatter.date(from: date)
    }

    static func convertDateToAppDateFormat(_ date: Date) -> String {
        let resultDateFormatter = DateFormatter()
        resultDateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        return resultDateFormatter.string(from: date)
    }
}
