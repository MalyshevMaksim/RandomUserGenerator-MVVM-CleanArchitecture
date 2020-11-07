//
//  User.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/29/20.
//

import Foundation
import RealmSwift

@objcMembers final class UserList: Object, Codable {
    dynamic var results: List<User> = .init()
}

@objcMembers final class User: Object, Codable {
    dynamic var name: UserName?
    dynamic var location: Location?
    dynamic var email = ""
    dynamic var gender = ""
    dynamic var phone = ""
    dynamic var dob: DateBirth?
    dynamic var registered: DateRegistered?
    dynamic var picture: Pictures?
}

@objcMembers final class UserName: Object, Codable {
    dynamic var first = ""
    dynamic var last = ""
    
    var fullName: String {
        return first + " " + last
    }
}

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

@objcMembers final class DateRegistered: Object, Codable {
    dynamic var date = ""
}

@objcMembers final class Pictures: Object, Codable {
    dynamic var large = ""
    dynamic var medium = ""
    dynamic var thumbnail = ""
}
