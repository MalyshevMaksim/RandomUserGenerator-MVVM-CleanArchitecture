//
//  RealmStorage.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/28/20.
//

import Foundation
import RealmSwift

class UsersRealmStorage: UsersPersistentStorage {
    private var realm: Realm = try! Realm()
    
    func fetch() -> [User] {
        return realm.objects(User.self).toArray()
    }
    
    func save(user: User) {
        try! realm.write {
            realm.add(user)
        }
    }
    
    func delete(user: User) {
        try! realm.write {
            realm.delete(user)
        }
    }
}
