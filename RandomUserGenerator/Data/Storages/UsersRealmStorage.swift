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
        user.uuid = UUID().uuidString
        try! realm.write {
            realm.create(User.self, value: user, update: .all)
        }
    }
    
    func delete(user: User) {
        guard let deleted = realm.object(ofType: User.self, forPrimaryKey: user.uuid) else {
            return
        }
        try! realm.write {
            realm.delete(deleted)
        }
    }
}
