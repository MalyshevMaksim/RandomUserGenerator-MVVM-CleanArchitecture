//
//  ViewModelAssemblies.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 1/17/21.
//

import Swinject

class SavedUserViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(SavedUserViewModel.self) { resolver in
            
            let repository = resolver.resolve(UsersPersistentRepository.self)!
            let fethedUseCase = FetchUserInteractor(repository: repository)
            let searchUseCase = SearchUserInteractor()
            let deleteUseCase = DeleteInteractor(repository: repository)
            
            return SavedUserViewModel(fetchUseCase: fethedUseCase,
                                      searchUseCase: searchUseCase,
                                      deleteUseCase: deleteUseCase,
                                      router: Router())
        }
    }
}


class UserGeneratorViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(UserGeneratorViewModel.self) { resolver in
            
            let repository = resolver.resolve(UsersNetworkRepository.self)!
            let fethedUseCase = FetchUserInteractor(repository: repository)
            let saveUseCase = SaveUserInteractor(usersRepository: repository)
            let deleteUseCase = DeleteInteractor(repository: repository)
            
            return UserGeneratorViewModel(generateUseCase: fethedUseCase,
                                          saveUseCase: saveUseCase,
                                          deleteUseCase: deleteUseCase,
                                          router: Router())
        }
    }
}
