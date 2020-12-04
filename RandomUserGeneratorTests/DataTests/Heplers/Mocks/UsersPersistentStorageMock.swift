//
//  UsersPersistentStorageMock.swift
//  RandomUserGeneratorTests
//
//  Created by Малышев Максим Алексеевич on 12/4/20.
//

import Foundation

@testable import RandomUserGenerator

class UsersPersistentStorageMock: UsersPersistentStorage {
    
    private var users: [User] = []
    
    init(savedUsers: [User]) {
        self.users = savedUsers
    }
    
    func save(user: User) {
        users.append(user)
    }
    
    func delete(user: User) {
        let index = users.firstIndex(of: user)
        users.remove(at: index!)
    }
    
    func fetch() -> [User] {
        return users
    }
}
