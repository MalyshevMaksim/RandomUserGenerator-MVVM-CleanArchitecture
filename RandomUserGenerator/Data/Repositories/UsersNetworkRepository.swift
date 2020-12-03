//
//  NetworkRepository.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/28/20.
//

import Foundation

class UsersNetworkRepository: UsersRepository {
    
    private var persistentStorage: UsersPersistentStorage
    private var networkService: NetworkServiceProtocol
    
    init(storage: UsersPersistentStorage, networkService: NetworkServiceProtocol) {
        self.persistentStorage = storage
        self.networkService = networkService
    }
    
    func fetch(completion: @escaping ([User]?, NSError?) -> ()) {
        guard networkService.url != nil else {
            completion(nil, NSError.makeError(withMessage: "Invalid URL"))
            return
        }
        networkService.execute { (result: Result<UserList, NSError>) in
            switch result {
                case .success(let users):
                    completion(users.toArray(), nil)
                case .failure(let error):
                    completion(nil, error)
            }
        }
    }
    
    func save(user: User) {
        persistentStorage.save(user: user)
    }
    
    func delete(user: User) {
        persistentStorage.delete(user: user)
    }
}
