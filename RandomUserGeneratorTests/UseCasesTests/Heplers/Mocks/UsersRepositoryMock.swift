//
//  UsersRepositoryMock.swift
//  RandomUserGeneratorTests
//
//  Created by Малышев Максим Алексеевич on 12/3/20.
//

@testable import RandomUserGenerator
import Foundation

class UsersRepositoryMock: UsersRepository {
    
    var users: [User]?
    
    init(usersStub: [User]?) {
        self.users = usersStub
    }
    
    func fetch(completion: @escaping ([User]?, NSError?) -> ()) {
        guard let users = users else {
            completion(nil, NSError.makeError(withMessage: "foo"))
            return
        }
        completion(users, nil)
    }
    
    func save(user: User) {
        users?.append(user)
    }
    
    func delete(user: User) {
        let index = users?.firstIndex(of: user)
        users?.remove(at: index!)
    }
}
