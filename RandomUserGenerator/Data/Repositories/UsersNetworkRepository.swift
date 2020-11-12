//
//  NetworkRepository.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/28/20.
//

import Foundation
import Alamofire

class UsersNetworkRepository: UsersRepository {
    private var persistentStorage: UsersPersistentStorage
    
    init(storage: UsersPersistentStorage) {
        self.persistentStorage = storage
    }
    
    func fetch(completion: @escaping (UserList?, AFError?) -> ()) {
        AF.request("https://randomuser.me/api/") { $0.timeoutInterval = 5 }.validate().responseDecodable(of: UserList.self) { response in
            switch response.result {
                case .success(let users):
                    self.fetchPicture(for: users)
                    completion(users, nil)
                case .failure(let error):
                    completion(nil, error)
            }
        }
    }
    
    private func fetchPicture(for users: UserList) {
        for user in users.results {
            guard let url = users.results.first?.picture?.large else {
                break
            }
            AF.request(url).validate().response { response in
                switch response.result {
                    case .success(let pictureData):
                        user.picture?.data = pictureData
                    case .failure:
                        user.picture?.data = nil
                }
            }
        }
    }
    
    func save(user: User) {
        persistentStorage.save(user: user)
    }
    
    func delete(user: User) {
        
    }
}
