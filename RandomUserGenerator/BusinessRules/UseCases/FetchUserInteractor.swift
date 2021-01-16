//
//  UseCase.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/28/20.
//

import Foundation

protocol FetchUserInteractorInput {
    func execute(completionUser: @escaping (Result<[User], NSError>) -> ())
}

class FetchUserInteractor: FetchUserInteractorInput {
    
    private var repository: UsersRepository
    
    init(repository: UsersRepository) {
        self.repository = repository
    }
    
    func execute(completionUser: @escaping (Result<[User], NSError>) -> ()) {
        repository.fetch { user, error in
            guard let user = user else {
                completionUser(.failure(error!))
                return
            }
            completionUser(.success(user))
        }
    }
}
