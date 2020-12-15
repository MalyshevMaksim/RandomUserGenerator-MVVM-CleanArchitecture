//
//  DeleteUseCase.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/12/20.
//

protocol DeleteUserInteractorInput {
    func execute(user: User)
}

class DeleteInteractor: DeleteUserInteractorInput {
    
    private var repository: UsersRepository
    
    init(repository: UsersRepository) {
        self.repository = repository
    }
    
    func execute(user: User) {
        repository.delete(user: user)
    }
}
