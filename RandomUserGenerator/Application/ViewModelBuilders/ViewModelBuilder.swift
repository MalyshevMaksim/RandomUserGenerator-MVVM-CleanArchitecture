//
//  ViewModelBuilder.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/8/20.
//

import Foundation

protocol ViewModelBuilder {
    func setUsersRepository(usersRepository: UsersRepository)
    func setPicturesRepository(picturesRepository: PicturesRepository)
    func build()
}
