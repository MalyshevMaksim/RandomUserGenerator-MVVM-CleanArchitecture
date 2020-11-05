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
    func fetch() -> [UIImage]
}

class PicturesRealmStorage: PicturesPersistentStorage {
    private var realm: Realm = try! Realm()
    
    func fetch() -> [UIImage] {
        let imagesData = realm.objects(ImageData.self)
        var images: [UIImage] = []
        
        for data in imagesData {
            let image = UIImage(data: data.data!)
            images.append(image!)
        }
        return images
    }
    
    func save(picture: UIImage) {
        let image = ImageData()
        image.data = picture.pngData()!

        try! realm.write {
            realm.add(image)
        }
    }
}

@objcMembers class ImageData: Object {
    dynamic var data: Data?
}
