//
//  UserRepository.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/28/20.
//

import Foundation
import RealmSwift
import Alamofire

protocol UsersRepository {
    func fetch(completion: @escaping (User?, AFError?) -> ())
    func fetchPicture(for user: User, completion: @escaping (UIImage?) -> ())
    func saveUser(user: User)
}
