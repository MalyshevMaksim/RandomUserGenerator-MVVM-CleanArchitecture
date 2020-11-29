//
//  Pictures.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/29/20.
//

import Foundation
import RealmSwift

@objcMembers final class Pictures: Object, Codable {
    dynamic var large = ""
    dynamic var medium = ""
    dynamic var thumbnail = ""
    dynamic var data: Data?
}
