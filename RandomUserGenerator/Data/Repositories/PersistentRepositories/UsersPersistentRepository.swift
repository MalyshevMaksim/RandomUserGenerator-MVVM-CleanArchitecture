//
//  UsersPersistentRepository.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/2/20.
//

import Foundation
import Alamofire

class UsersPersistentRepository: UsersRepository {
    private var persistentStorage: UsersPersistentStorage
    
    init(storage: UsersPersistentStorage) {
        self.persistentStorage = storage
    }
    
    func fetch(completion: @escaping (User?, AFError?) -> ()) {
        let users = persistentStorage.fetch()
        //completion(users, nil)
    }
    
    func save(user: User) {
        persistentStorage.save(user: user)
    }
}
