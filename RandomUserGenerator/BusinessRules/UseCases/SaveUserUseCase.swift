//
//  SaveUserInteractor.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/2/20.
//

protocol SaveUserUseCase {
    func execute(user: User)
}

class SaveUserInteractor: SaveUserUseCase {
    
    private var usersRepository: UsersRepository
    
    init(usersRepository: UsersRepository) {
        self.usersRepository = usersRepository
    }
    
    func execute(user: User) {
        usersRepository.save(user: user)
    }
}
