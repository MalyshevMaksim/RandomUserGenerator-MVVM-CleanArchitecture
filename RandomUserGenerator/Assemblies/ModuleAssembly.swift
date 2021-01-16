//
//  ModuleAssembly.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 1/16/21.
//

import Swinject


class ModuleAssembly {

    private let container = Container()
    private let assembler: Assembler

    init() {
        assembler = Assembler([
            PersistentRealmRepositoryAssembly(),
            AlamofireNetworkRepostoryAssembly(),
            UserGeneratorViewModelAssembly(),
            SavedUserViewModelAssembly(),
            SavedUserViewControllerAssembly(),
            UserGeneratorViewControllerAssembly()
        ],
        container: container)
    }
    
    func makeGenerateUserModule() -> UIViewController {
        return container.resolve(UserGeneratorViewController.self)!
    }
    
    func makeSavedUserModule() -> UIViewController {
        return container.resolve(SavedUserViewController.self)!
    }
}
