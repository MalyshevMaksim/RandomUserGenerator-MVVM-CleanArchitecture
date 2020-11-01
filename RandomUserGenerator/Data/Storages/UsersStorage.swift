//
//  RealmStorage.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/28/20.
//

import Foundation
import RealmSwift

protocol UsersStorage {
    func save(user: User)
}

class UsersRealmStorage: UsersStorage {
    private var realm: Realm = try! Realm()
    
    func save(user: User) {
       
    }
}
