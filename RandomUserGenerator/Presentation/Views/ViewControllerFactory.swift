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
        let generateUseCase = FetchUserInteractor(repository: repository)
        let saveUseCase = SaveUserInteractor(usersRepository: repository)
        let viewModel = UserGeneratorViewModel(generateUseCase: generateUseCase, saveUseCase: saveUseCase)
        return UserGeneratorViewController(viewModel: viewModel)
    }
}

class SavedUserViewControllerFactory: ViewControllerFactory {
    
    func makeViewController(router: Router) -> UIViewController {
        let storage = UsersRealmStorage()
        let repository = UsersPersistentRepository(storage: storage)
        let fetchUseCase = FetchUserInteractor(repository: repository)
        let viewModel = SavedUserViewModel(fetchUseCase: fetchUseCase, router: router)
        return SavedUserViewController(viewModel: viewModel)
    }
}
