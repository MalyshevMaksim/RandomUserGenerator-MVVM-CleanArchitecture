//
//  UserName.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/29/20.
//

import Foundation
import RealmSwift

@objcMembers final class UserName: Object, Codable {
    dynamic var first = ""
    dynamic var last = ""
    
    var fullName: String {
        return first + " " + last
    }
}
