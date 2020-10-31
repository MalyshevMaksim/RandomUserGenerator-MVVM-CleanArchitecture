//
//  UsersPersitentStorage.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/28/20.
//

import Foundation
import RealmSwift

protocol UsersPersistentStorage {
    func fetchRecentQueries() -> [String]
    func fetchUsers() -> Results<User>
    func saveQuery(query: String)
    func saveUser(user: User)
}
