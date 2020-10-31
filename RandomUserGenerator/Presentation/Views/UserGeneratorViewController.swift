//
//  ViewController.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/28/20.
//

import UIKit
import Bond

class ViewController: UIViewController {
    private var viewModel = UserGeneratorViewModel(useCase: GenerateUserUseCase(repository: NetworkRepository(storage: RealmStorage())))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        bindViewModel()
    }
    
    private func bindViewModel() {
        _ = navigationItem.leftBarButtonItem?.reactive.tap.observeNext { self.viewModel.executeUseCase() }
        _ = viewModel.generatedUser.observeNext { generatedUser in print(generatedUser) }
        _ = viewModel.error?.observeNext { error in }
    }
}
