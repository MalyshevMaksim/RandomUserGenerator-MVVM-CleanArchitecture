//
//  ViewModelDirector.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/8/20.
//

import Foundation

class ViewModelDirector {
    private var builder: ViewModelBuilder
    
    init(builder: ViewModelBuilder) {
        self.builder = builder
    }
    
    func setBuilder(builder: ViewModelBuilder) {
        self.builder = builder
    }
    
    func makeSavedUserViewModel() {
        let usersStorage = UsersRealmStorage()
        let pictureStorage = PicturesRealmStorage()
        builder.setUsersRepository(usersRepository: UsersPersistentRepository(storage: usersStorage))
        builder.setPicturesRepository(picturesRepository: PicturesPersistentRepository(storage: pictureStorage))
        builder.build()
    }
    
    func makeUserGeneratorViewModel() {
        let usersStorage = UsersRealmStorage()
        let picturesStorage = PicturesRealmStorage()
        builder.setUsersRepository(usersRepository: UsersNetworkRepository(storage: usersStorage))
        builder.setPicturesRepository(picturesRepository: PicturesNetworkRepository(storage: picturesStorage))
        builder.build()
    }
}
