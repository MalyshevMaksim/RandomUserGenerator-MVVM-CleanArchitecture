//
//  UseCase.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/28/20.
//

import Foundation
import Alamofire

protocol UseCase {
    func execute(completion: @escaping (Result<[User], AFError>) -> ())
}

class GenerateUserUseCase: UseCase {
    private var repository: UsersRepository
    
    init(repository: UsersRepository) {
        self.repository = repository
    }
    
    func execute(completion: @escaping (Result<[User], AFError>) -> ()) {
        repository.generateUser { user, error in
            guard let user = user else {
                completion(.failure(error!))
                return
            }
            completion(.success(user))
        }
    }
}
