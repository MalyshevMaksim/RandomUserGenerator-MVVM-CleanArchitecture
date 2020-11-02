//
//  NetworkRepository.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/28/20.
//

import Foundation
import Alamofire

protocol UsersRepository {
    func fetch(completion: @escaping (User?, AFError?) -> ())
    func save(user: User)
}

class UsersNetworkRepository: UsersRepository {
    private var persistentStorage: UsersPersistentStorage
    
    init(storage: UsersPersistentStorage) {
        self.persistentStorage = storage
    }
    
    func fetch(completion: @escaping (User?, AFError?) -> ()) {
        AF.request("https://randomuser.me/api/") { $0.timeoutInterval = 5 }.validate().responseDecodable(of: User.self) { response in
            switch response.result {
                case .success(let user):
                    completion(user, nil)
                case .failure(let error):
                    completion(nil, error)
            }
        }
    }
    
    func save(user: User) {
        persistentStorage.save(user: user)
    }
}
