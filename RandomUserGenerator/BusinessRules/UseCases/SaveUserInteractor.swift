//
//  SaveUserInteractor.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/2/20.
//

protocol SaveUserInteractorInput {
    func execute(user: User)
}

class SaveUserInteractor: SaveUserInteractorInput {
    
    private var usersRepository: UsersRepository
    
    init(usersRepository: UsersRepository) {
        self.usersRepository = usersRepository
    }
    
    func execute(user: User) {
        usersRepository.save(user: user)
    }
}
