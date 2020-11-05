//
//  UsersPersistentRepository.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/2/20.
//

import Foundation
import Alamofire
import RealmSwift

class UsersPersistentRepository: UsersRepository {
    private var persistentStorage: UsersPersistentStorage
    
    init(storage: UsersPersistentStorage) {
        self.persistentStorage = storage
    }
    
    func fetch(completion: @escaping (UserList?, AFError?) -> ()) {
        let users = persistentStorage.fetch()
        let list = UserList()
        for user in users {
            list.results.append(user)
        }
        completion(list, nil)
    }
    
    func save(user: User) {
        persistentStorage.save(user: user)
    }
}
