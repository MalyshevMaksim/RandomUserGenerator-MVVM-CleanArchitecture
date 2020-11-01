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
    
    func fetchPicture(for user: User, completion: @escaping (UIImage?) -> ()) {
        guard let url = user.results.first?.picture?.large else {
            completion(nil)
            return
        }
        AF.request(url).validate().response { response in
            switch response.result {
                case .success(let pictureData):
                    guard let data = pictureData, let image = UIImage(data: data) else {
                        completion(nil)
                        return
                    }
                    completion(image)
                case .failure:
                    completion(nil)
            }
        }
    }
    
    func saveUser(user: User) {
        persistentStorage.saveUser(user: user)
    }
}
