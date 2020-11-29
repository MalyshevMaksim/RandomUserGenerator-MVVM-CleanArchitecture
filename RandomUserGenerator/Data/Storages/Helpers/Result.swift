//
//  Result.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/2/20.
//

import RealmSwift

extension Results {
    func toArray() -> [Element] {
        return compactMap { $0 }
    }
 }
