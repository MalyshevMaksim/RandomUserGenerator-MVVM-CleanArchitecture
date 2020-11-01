//
//  ViewController.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/28/20.
//

import UIKit
import Bond

class UserGeneratorViewController: UIViewController, Alertable {
    private var viewModel = UserGeneratorViewModel(useCase: GenerateUserUseCase(repository: NetworkRepository(storage: UserStorage())))
    private var activityIndicator = UIActivityIndicatorView(style: .large)
    private var userCardView: GeneratedUserCardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        bindViewModel()
        viewModel.executeUseCase()
    }
    
    private func configureViewController() {
        configureView()
        configureActivityIndicator()
        configureUserView()
    }
    
    private func configureView() {
        title = "User Generator"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        let rightBarButtonIcon = UIImage(systemName: "die.face.5.fill")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightBarButtonIcon, style: .plain, target: nil, action: nil)
    }
    
    private func configureActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.snp.makeConstraints { make in make.center.equalToSuperview() }
    }
    
    private func configureUserView() {
        userCardView = GeneratedUserCardView(frame: view.frame)
        view.addSubview(userCardView)
    }
    
    private func bindViewModel() {
        bindViewModelUserGenerated()
        bindViewModelPicture()
        bindViewModelError()
        bindBarButtonTap()
    }
    
    private func bindViewModelUserGenerated() {
        _ = viewModel.generatedUser.observeNext { generatedUser in
            guard let user = generatedUser else {
                return
            }
            self.userCardView.configure(user: user) { success in
                if success {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    private func bindViewModelPicture() {
        _ = viewModel.generatedPicture.observeNext { image in
            self.userCardView.poster.image = image
        }
    }
    
    private func bindViewModelError() {
        _ = viewModel.generatedError.observeNext { [unowned self] error in
            guard let error = error else { return }
            showError(text: error.localizedDescription) { cancelAction in
                activityIndicator.stopAnimating()
            } retryAction: { action in
                viewModel.executeUseCase()
            }
        }
    }
    
    private func bindBarButtonTap() {
        _ = navigationItem.rightBarButtonItem?.reactive.tap.observeNext {
            self.activityIndicator.startAnimating()
            self.viewModel.executeUseCase()
        }
    }
}
