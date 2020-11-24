//
//  Router.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/8/20.
//

import Foundation
import UIKit

class Router {
    enum PresentationMethod {
        case present
        case push
    }
    
    private var rootNavigationController: UINavigationController
    private var viewControllerFactory: ViewControllerFactory
    
    init(rootNavigationController: UINavigationController, factory: ViewControllerFactory) {
        self.rootNavigationController = rootNavigationController
        self.viewControllerFactory = factory
    }
    
    func initialSubjectNavigationController() {
        let rootViewController = viewControllerFactory.makeViewController(router: self)
        rootNavigationController.viewControllers = [rootViewController]
    }
    
    func showDetail(user: User, method: PresentationMethod) {
        let detailViewController = viewControllerFactory.makeDetailViewController()
        
        switch method {
            case .present:
                rootNavigationController.present(detailViewController, animated: true, completion: nil)
            case .push:
                rootNavigationController.pushViewController(detailViewController, animated: true)
        }
    }
}
