//
//  UserGeneratorViewModelAssembly.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 1/24/21.
//

import Foundation
import Swinject
import RealmSwift

class UserGeneratorViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(UsersNetworkRepository.self) { _  in
            let networkService = AlamofireNetworkService(url: URL(string: "https://randomuser.me/api/"))
            let realmStorage = UsersRealmStorage(realm: try! Realm())
            return UsersNetworkRepository(storage: realmStorage, networkService: networkService)
        }
        
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
        
        container.register(UserGeneratorViewController.self) { resolver in
            let viewModel = resolver.resolve(UserGeneratorViewModel.self)!
            let viewController = UserGeneratorViewController()
            viewController.viewModelInput = viewModel
            viewController.viewModelOutput = viewModel
            return viewController
        }
    }
}

