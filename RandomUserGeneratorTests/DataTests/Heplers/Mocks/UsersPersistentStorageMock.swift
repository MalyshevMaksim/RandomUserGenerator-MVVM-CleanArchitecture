//
//  UsersPersistentStorageMock.swift
//  RandomUserGeneratorTests
//
//  Created by Малышев Максим Алексеевич on 12/4/20.
//

import Foundation

@testable import RandomUserGenerator

class UsersPersistentStorageMock: UsersPersistentStorage {
    
    var isUserSaved = false
    var isUserDeleted = false
    var isUsersFetched = false
    
    func save(user: User) {
        isUserSaved = true
    }
    
    func delete(user: User) {
        isUserDeleted = true
    }
    
    func fetch() -> [User] {
        isUsersFetched = true
        return []
    }
}
