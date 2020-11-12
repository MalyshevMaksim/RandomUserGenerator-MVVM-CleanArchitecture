//
//  UsersRepository.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/8/20.
//

import Foundation
import Alamofire

protocol UsersRepository {
    func fetch(completion: @escaping (UserList?, AFError?) -> ())
    func save(user: User)
    func delete(user: User)
}
