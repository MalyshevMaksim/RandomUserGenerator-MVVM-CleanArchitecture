//
//  DeleteUseCase.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/12/20.
//

import Foundation

protocol DeleteUseCase {
    func execute(user: User)
}

class DeleteInteractor: DeleteUseCase {
    private var repository: UsersRepository
    
    init(repository: UsersRepository) {
        self.repository = repository
    }
    
    func execute(user: User) {
        repository.delete(user: user)
    }
}
