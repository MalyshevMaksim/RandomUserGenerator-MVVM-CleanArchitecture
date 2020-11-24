//
//  RouterDIContainer.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/24/20.
//

import Foundation
import Swinject

enum FactoryType: String {
    case userGenerator = "User Generator"
    case savedUser = "Saved User"
}

class RouterDIContainer {
    private let containter = Container()
    
    init() {
        register()
    }
    
    func get(type: FactoryType, subjectNavigation: UINavigationController) -> Router? {
        return containter.resolve(Router.self, name: type.rawValue, argument: subjectNavigation)
    }
    
    private func register() {
        containter.register(Router.self, name: "User Generator") { (_, subject: UINavigationController) in
            return Router(rootNavigationController: subject, factory: UserGeneratorViewControllerFactory())
        }
        
        containter.register(Router.self, name: "Saved User") { (_, subject: UINavigationController) in
            return Router(rootNavigationController: subject, factory: SavedUserViewControllerFactory())
        }
    }
}
