//
//  RealmStorage.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/28/20.
//

import Foundation
import RealmSwift

class UserStorage: UsersPersistentStorage {
    private var realm: Realm = try! Realm()
    
    func fetchRecentQueries() -> [String] {
        return [""]
    }
    
    func fetchUsers() -> Results<User> {
        return realm.objects(User.self)
    }
    
    func saveQuery(query: String) {
        try! realm.write {
            
        }
    }
    
    func saveUser(user: User) {
        try! realm.write {
            realm.add(user)
        }
    }
}
