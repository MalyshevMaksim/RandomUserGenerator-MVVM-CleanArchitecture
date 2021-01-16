//
//  ViewControllerAssemblies.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 1/17/21.
//

import Swinject

class UserGeneratorViewControllerAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(UserGeneratorViewController.self) { resolver in
            let viewModel = resolver.resolve(UserGeneratorViewModel.self)!
            let viewController = UserGeneratorViewController()
            viewController.viewModelInput = viewModel
            viewController.viewModelOutput = viewModel
            return viewController
        }
    }
}

class SavedUserViewControllerAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(SavedUserViewController.self) { resolver in
            let viewModel = resolver.resolve(SavedUserViewModel.self)!
            return SavedUserViewController(input: viewModel, output: viewModel)
        }
    }
}
