//
//  SavedUserBuilder.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/8/20.
//

import Foundation

class SavedUserBuilder: ViewModelBuilder {
    private var result: SavedUserViewModel?
    private var usersRepository: UsersRepository?
    private var picturesRepository: PicturesRepository?
    private var usersStorage: UsersPersistentStorage?
    private var picturesStorage: PicturesPersistentStorage?
    
    func setUsersRepository(usersRepository: UsersRepository) {
        self.usersRepository = usersRepository
    }
    
    func setPicturesRepository(picturesRepository: PicturesRepository) {
        self.picturesRepository = picturesRepository
    }
    
    func build() {
        let fetchInteractor = FetchUserInteractor(usersRepository: usersRepository!, picturesRepository: picturesRepository!)
        result = SavedUserViewModel(fetchUseCase: fetchInteractor)
    }
    
    func getResult() -> SavedUserViewModel? {
        return result
    }
}
