//
//  SaveUserInteractor.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/2/20.
//

import Foundation
import UIKit

protocol SaveUseCase {
    func execute(for user: User, with picture: UIImage)
}

class SaveUserInteractor: SaveUseCase {
    private var usersRepository: UsersRepository
    private var picturesRepository: PicturesRepository
    
    init(usersRepository: UsersRepository, picturesRepository: PicturesRepository) {
        self.usersRepository = usersRepository
        self.picturesRepository = picturesRepository
    }
    
    func execute(for user: User, with picture: UIImage) {
        usersRepository.save(user: user)
        picturesRepository.save(picture: picture)
    }
}
