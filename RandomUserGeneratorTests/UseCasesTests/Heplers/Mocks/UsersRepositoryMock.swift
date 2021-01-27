//
//  UsersRepositoryMock.swift
//  RandomUserGeneratorTests
//
//  Created by Малышев Максим Алексеевич on 12/3/20.
//

@testable import RandomUserGenerator
import Foundation

class UsersRepositoryMock: UsersRepository {
    
    var isUserSaved = false
    var isUserDeleted = false
    var fetchedUsers: [User]?
    
    func fetch(completion: @escaping ([User]?, NSError?) -> ()) {
        guard let users = fetchedUsers else {
            completion(nil, NSError.makeError(withMessage: "foosss"))
            return
        }
        completion(users, nil)
    }
    
    func save(user: User) {
        isUserSaved = true
    }
    
    func delete(user: User) {
        isUserDeleted = true
    }
}
