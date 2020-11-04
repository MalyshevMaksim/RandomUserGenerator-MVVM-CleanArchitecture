//
//  NetworkPictureRepository.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/1/20.
//

import Foundation
import Alamofire

protocol PicturesRepository {
    func fetch(for user: UserList, completion: @escaping (UIImage?) -> ())
    func save(picture: UIImage)
}

class PicturesNetworkRepository: PicturesRepository {
    private var persistentStorage: PicturesPersistentStorage
    
    init(storage: PicturesPersistentStorage) {
        self.persistentStorage = storage
    }
    
    func fetch(for user: UserList, completion: @escaping (UIImage?) -> ()) {
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
    
    func save(picture: UIImage) {
        persistentStorage.save(picture: picture)
    }
}
