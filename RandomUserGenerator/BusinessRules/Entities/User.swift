//
//  User.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/29/20.
//

import Foundation
import RealmSwift

@objcMembers final class User: Object, Codable {
    dynamic var uuid: String?
    dynamic var name: UserName?
    dynamic var location: Location?
    dynamic var email = ""
    dynamic var gender = ""
    dynamic var phone = ""
    dynamic var dob: DateBirth?
    dynamic var registered: DateRegistered?
    dynamic var picture: Pictures?

    override class func primaryKey() -> String? {
        return "uuid"
    }
}

@objcMembers final class DateRegistered: Object, Codable {
    dynamic var date = ""
}
