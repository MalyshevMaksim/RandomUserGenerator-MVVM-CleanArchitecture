//
//  Location.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/29/20.
//

import Foundation
import RealmSwift

@objcMembers final class Location: Object, Codable {
    
    dynamic var street: Street?
    dynamic var city = ""
    dynamic var state = ""
    dynamic var country = ""
    dynamic var coordinates: Coordinates?
    
    var fullLocation: String {
        return country + ", " + city
    }
}

@objcMembers final class Street: Object, Codable {
    
    dynamic var number = 0
    dynamic var name = ""
}

@objcMembers final class Coordinates: Object, Codable {
    
    dynamic var latitude = ""
    dynamic var longitude = ""
}
