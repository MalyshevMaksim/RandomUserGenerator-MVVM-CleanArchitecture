//
//  PictureStorage.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/1/20.
//

import Foundation
import RealmSwift

protocol PicturesStorage {
    func save(picture: UIImage)
}

class PicturesRealmStorage: PicturesStorage {
    private var realm: Realm = try! Realm()
    
    func save(picture: UIImage) {
        
    }
}
