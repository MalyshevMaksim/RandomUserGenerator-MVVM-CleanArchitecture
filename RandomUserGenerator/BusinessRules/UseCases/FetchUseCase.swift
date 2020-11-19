//
//  UseCase.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/28/20.
//

import Foundation
import Alamofire

protocol FetchUseCase {
    func execute(completionUser: @escaping (Result<UserList, AFError>) -> ())
}

class FetchUserInteractor: FetchUseCase {
    
    private var repository: UsersRepository
    
    init(repository: UsersRepository) {
        self.repository = repository
    }
    
    func execute(completionUser: @escaping (Result<UserList, AFError>) -> ()) {
        repository.fetch { user, error in
            guard let user = user else {
                completionUser(.failure(error!))
                return
            }
            completionUser(.success(user))
        }
    }
}
