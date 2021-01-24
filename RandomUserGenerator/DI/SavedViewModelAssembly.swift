//
//  ViewControllerAssemblies.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 1/17/21.
//

import Swinject
import RealmSwift

class SavedViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(UsersPersistentRepository.self) { _ in
            let realmStorage = UsersRealmStorage(realm: try! Realm())
            return UsersPersistentRepository(storage: realmStorage)
        }
        
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
        
        container.register(SavedUserViewController.self) { resolver in
            let viewModel = resolver.resolve(SavedUserViewModel.self)!
            return SavedUserViewController(input: viewModel, output: viewModel)
        }
    }
}
