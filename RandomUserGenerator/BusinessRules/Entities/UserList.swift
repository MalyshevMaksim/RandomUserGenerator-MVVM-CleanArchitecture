//
//  User.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/29/20.
//

import RealmSwift

@objcMembers final class UserList: Object, Codable {
    dynamic var results: List<User> = .init()
    
    func toArray() -> [User] {
        return Array(results)
    }
}
