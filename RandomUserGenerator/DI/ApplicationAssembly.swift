//
//  ModuleAssembly.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 1/16/21.
//

import Swinject

class ApplicationAssembly {

    private let container = Container()
    let assembler: Assembler

    init() {
        assembler = Assembler([
            UserGeneratorViewModelAssembly(),
            SavedViewModelAssembly()
        ],
        container: container)
    }
}
