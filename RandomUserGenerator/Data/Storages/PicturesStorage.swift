//
//  PictureStorage.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/1/20.
//

import Foundation
import RealmSwift

protocol PicturesPersistentStorage {
    func save(picture: UIImage)
}

class PicturesRealmStorage: PicturesPersistentStorage {
    private var realm: Realm = try! Realm()
    
    func save(picture: UIImage) {
        
    }
}
