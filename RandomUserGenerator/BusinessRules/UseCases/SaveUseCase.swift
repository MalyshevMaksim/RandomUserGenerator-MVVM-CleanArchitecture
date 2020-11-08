//
//  SaveUserInteractor.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/2/20.
//

import Foundation
import UIKit

protocol SaveUseCase {
    func execute(user: User)
}

class SaveUserInteractor: SaveUseCase {
    private var usersRepository: UsersRepository
    
    init(usersRepository: UsersRepository) {
        self.usersRepository = usersRepository
    }
    
    func execute(user: User) {
        usersRepository.save(user: user)
    }
}
