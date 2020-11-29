//
//  UsersRepository.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/8/20.
//

import Alamofire

protocol UsersRepository {
    func fetch(completion: @escaping ([User]?, NSError?) -> ())
    func save(user: User)
    func delete(user: User)
}
