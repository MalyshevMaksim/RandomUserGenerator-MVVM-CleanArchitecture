//
//  UserGeneratorBuilder.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/8/20.
//

import Foundation

class UserGeneratorViewModelBuilder: ViewModelBuilder {
    private var result: UserGeneratorViewModel?
    private var usersRepository: UsersRepository?
    private var picturesRepository: PicturesRepository?

    func setUsersRepository(usersRepository: UsersRepository) {
        self.usersRepository = usersRepository
    }
    
    func setPicturesRepository(picturesRepository: PicturesRepository) {
        self.picturesRepository = picturesRepository
    }
    
    func build() {
        let fetchInteractor = FetchUserInteractor(usersRepository: usersRepository!, picturesRepository: picturesRepository!)
        let saveInteractor = SaveUserInteractor(usersRepository: usersRepository!, picturesRepository: picturesRepository!)
        result = UserGeneratorViewModel(generateUseCase: fetchInteractor, saveUseCase: saveInteractor)
    }
    
    func getResult() -> UserGeneratorViewModel? {
        return result
    }
}
