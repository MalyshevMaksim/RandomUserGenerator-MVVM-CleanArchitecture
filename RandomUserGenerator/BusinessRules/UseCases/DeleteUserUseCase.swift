//
//  DeleteUseCase.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/12/20.
//

protocol DeleteUserUseCase {
    func execute(user: User)
}

class DeleteInteractor: DeleteUserUseCase {
    
    private var repository: UsersRepository
    
    init(repository: UsersRepository) {
        self.repository = repository
    }
    
    func execute(user: User) {
        repository.delete(user: user)
    }
}
