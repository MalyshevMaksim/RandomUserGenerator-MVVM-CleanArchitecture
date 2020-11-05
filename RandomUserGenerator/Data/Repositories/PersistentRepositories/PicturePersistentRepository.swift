//
//  PicturePersistentRepository.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/2/20.
//

import Foundation
import UIKit

class PicturesPersistentRepository: PicturesRepository {
    private var persistentStorage: PicturesPersistentStorage
    
    init(storage: PicturesPersistentStorage) {
        self.persistentStorage = storage
    }
    
    func fetch(for user: UserList, completion: @escaping ([UIImage]?) -> ()) {
        let pictures = persistentStorage.fetch()
        completion(pictures)
    }
    
    func save(picture: UIImage) {
        persistentStorage.save(picture: picture)
    }
}
