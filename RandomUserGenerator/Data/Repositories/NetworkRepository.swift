//
//  NetworkRepository.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/28/20.
//

import Foundation
import Alamofire
import RealmSwift

class NetworkRepository: UsersRepository {
    private var cache: UsersPersistentStorage
    
    init(storage: UsersPersistentStorage) {
        self.cache = storage
    }
    
    func generateUser() {
        AF.request("https://jsonplaceholder.typicode.com/users").validate().responseDecodable(of: User.self) { response in
            switch response.result {
                case .success(let user):
                    print(user)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func fetchUsers() -> Results<User> {
        return cache.fetchUsers()
    }
    
    func fetchRecentQueries() -> [String] {
        return cache.fetchRecentQueries()
    }
    
    func saveQuery(query: String) {
        cache.saveQuery(query: query)
    }
    
    func saveUser(user: User) {
        cache.saveUser(user: user)
    }
}
