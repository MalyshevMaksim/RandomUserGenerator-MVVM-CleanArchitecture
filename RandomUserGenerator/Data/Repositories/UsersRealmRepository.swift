//
//  UsersPersistentRepository.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/2/20.
//

import Alamofire

class UsersRealmRepository: UsersRepository {
    
    private var persistentStorage: UsersPersistentStorage
    
    init(storage: UsersPersistentStorage) {
        self.persistentStorage = storage
    }
    
    func fetch(completion: @escaping ([User]?, NSError?) -> ()) {
        let users = persistentStorage.fetch()
        completion(Array(users), nil)
    }
    
    func save(user: User) {
        persistentStorage.save(user: user)
    }
    
    func delete(user: User) {
        persistentStorage.delete(user: user)
    }
}
