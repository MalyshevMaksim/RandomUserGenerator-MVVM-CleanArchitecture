//
//  User.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/29/20.
//

import Foundation
import RealmSwift

@objcMembers class User: Object, Codable {
    dynamic var id: Int
    dynamic var title: String
    dynamic var body: String
}
