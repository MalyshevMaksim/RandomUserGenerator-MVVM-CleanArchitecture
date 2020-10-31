//
//  UserRepository.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/28/20.
//

import Foundation
import RealmSwift

@objcMembers class User: Object, Codable {
    dynamic var id: Int
    dynamic var name: String
    dynamic var email: String
}

protocol UsersRepository {
    func generateUser()
    func fetchUsers() -> Results<User>
    func fetchRecentQueries() -> [String]
    func saveQuery(query: String)
    func saveUser(user: User)
}
