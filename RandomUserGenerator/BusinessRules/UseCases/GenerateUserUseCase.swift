//
//  UseCase.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/28/20.
//

import Foundation
import Alamofire

protocol GenerateUseCase {
    func executeUser(completion: @escaping (Result<User, AFError>) -> ())
    func executePicture(user: User, completion: @escaping (Result<UIImage, AFError>) -> ())
}

class GenerateUserUseCase: GenerateUseCase {
    private var repository: UsersRepository
    
    init(repository: UsersRepository) {
        self.repository = repository
    }
    
    func executeUser(completion: @escaping (Result<User, AFError>) -> ()) {
        repository.fetch { user, error in
            guard let user = user else {
                completion(.failure(error!))
                return
            }
            completion(.success(user))
        }
    }
    
    func executePicture(user: User, completion: @escaping (Result<UIImage, AFError>) -> ()) {
        repository.fetchPicture(for: user) { image in
            guard let picture = image else {
                completion(.success(UIImage()))
                return
            }
            completion(.success(picture))
        }
    }
}
