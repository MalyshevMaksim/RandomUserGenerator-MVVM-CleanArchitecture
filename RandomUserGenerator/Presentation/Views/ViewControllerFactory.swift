//
//  ViewModelDirector.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/8/20.
//

import UIKit

protocol ViewControllerFactory {
    func makeViewController(router: Router) -> UIViewController
}

extension ViewControllerFactory {
    
    func makeDetailViewController() -> UIViewController {
        let detailViewController = UIViewController()
        detailViewController.view.backgroundColor = .systemBackground
        return detailViewController
    }
}

class UserGeneratorViewControllerFactory: ViewControllerFactory {
    
    func makeViewController(router: Router) -> UIViewController {
        let DIContainer = ViewModelInjector()
        let viewModel = DIContainer.get(type: UserGeneratorViewModel.self, router: router)
        return UserGeneratorViewController(viewModel: viewModel!)
    }
}

class SavedUserViewControllerFactory: ViewControllerFactory {

    func makeViewController(router: Router) -> UIViewController {
        let DIContainer = ViewModelInjector()
        let viewModel = DIContainer.get(type: SavedUserViewModel.self, router: router)
        return SavedUserViewController(viewModel: viewModel!)
    }
}
