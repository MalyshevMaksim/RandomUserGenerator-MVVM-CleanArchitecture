//
//  ViewModelDirector.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/8/20.
//

import Foundation
import UIKit

protocol ViewControllerFactory {
    func makeViewController(router: Router) -> UIViewController
}

class UserGeneratorViewControllerFactory: ViewControllerFactory {
    
    func makeViewController(router: Router) -> UIViewController {
        let storage = UsersRealmStorage()
        let repository = UsersNetworkRepository(storage: storage)
        
        let generateInteractor = FetchUserInteractor(repository: repository)
        let saveInteractor = SaveUserInteractor(usersRepository: repository)
        let deleteInteractor = DeleteInteractor(repository: repository)
        
        let viewModel = UserGeneratorViewModel(generateUseCase: generateInteractor, saveUseCase: saveInteractor, deleteUseCase: deleteInteractor, router: router)
        return UserGeneratorViewController(viewModel: viewModel)
    }
}

class SavedUserViewControllerFactory: ViewControllerFactory {
    
    func makeViewController(router: Router) -> UIViewController {
        let storage = UsersRealmStorage()
        let repository = UsersRealmRepository(storage: storage)
        
        let fetchInteractor = FetchUserInteractor(repository: repository)
        let searchInteractor = SearchUserInteractor()
        let deleteInteractor = DeleteInteractor(repository: repository)
        
        let viewModel = SavedUserViewModel(fetchUseCase: fetchInteractor, searchUseCase: searchInteractor, deleteUseCase: deleteInteractor, router: router)
        return SavedUserViewController(viewModel: viewModel)
    }
}
