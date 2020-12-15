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
        guard let viewModel = ViewModelInjector().get(type: UserGeneratorViewModel.self, router: router) else {
            fatalError("Error")
        }
        return UserGeneratorViewController(input: viewModel, output: viewModel)
    }
}

class SavedUserViewControllerFactory: ViewControllerFactory {

    func makeViewController(router: Router) -> UIViewController {
        guard let viewModel = ViewModelInjector().get(type: SavedUserViewModel.self, router: router) else {
            fatalError("Error")
        }
        return SavedUserViewController(input: viewModel, output: viewModel)
    }
}
