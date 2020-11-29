//
//  DateBirth.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/29/20.
//

import Foundation
import RealmSwift

@objcMembers final class DateBirth: Object, Codable {
    dynamic var date = ""
    dynamic var age = 0
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        guard let date = dateFormatter.date(from: date) else {
            return "Date()"
        }

        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = "MMM d, yyyy"
        let newStr = newDateFormatter.string(from: date)
        return newStr
    }
}
