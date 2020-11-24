//
//  InjectViewModel.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/23/20.
//

import Foundation
import Swinject

class ViewModelDIContainer {
    private let containter = Container()
    
    init() {
        registerUserGeneratorViewModel()
        registerSavedUserViewModel()
    }
    
    func get<T>(type: T.Type, router: Router) -> T? {
        return containter.resolve(type, argument: router)
    }
    
    private func registerUserGeneratorViewModel() {
        
        containter.register(UserGeneratorViewModel.self) { (_, router: Router) in
            let persistentStorage = UsersRealmStorage()
            let repository = UsersNetworkRepository(storage: persistentStorage)
            
            return UserGeneratorViewModel(generateUseCase: FetchUserInteractor(repository: repository), saveUseCase: SaveUserInteractor(usersRepository: repository), deleteUseCase: DeleteInteractor(repository: repository), router: router)
        }
    }
    
    private func registerSavedUserViewModel() {
    
        containter.register(SavedUserViewModel.self) { (_, router: Router) in
            let persistentStorage = UsersRealmStorage()
            let repository = UsersRealmRepository(storage: persistentStorage)
            
            return SavedUserViewModel(fetchUseCase: FetchUserInteractor(repository: repository), searchUseCase: SearchUserInteractor(), deleteUseCase: DeleteInteractor(repository: repository), router: router)
        }
    }
}
