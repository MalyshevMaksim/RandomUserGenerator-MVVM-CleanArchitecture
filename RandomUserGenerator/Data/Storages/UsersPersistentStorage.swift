//
//  UsersPersistentStorage.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/8/20.
//

protocol UsersPersistentStorage {
    func save(user: User)
    func delete(user: User)
    func fetch() -> [User]
}
