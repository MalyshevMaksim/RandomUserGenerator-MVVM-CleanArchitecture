//
//  ViewController.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/28/20.
//

import UIKit
import Bond
import SnapKit

class UserGeneratorViewController: UIViewController, Alertable {
    
    private var viewModel: UserGeneratorViewModel!
    private var userCardView: GeneratedUserCardView!
    private var activityIndicator = UIActivityIndicatorView(style: .large)
    
    init(viewModel: UserGeneratorViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        bindViewModel()
        viewModel.generateUser()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        userCardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
        activityIndicator.snp.makeConstraints { $0.center.equalToSuperview() }
    }
    
    private func configureUserView() {
        userCardView = GeneratedUserCardView(frame: view.frame)
        view.addSubview(userCardView)
    }
    
    private func bindViewModel() {
        bindViewModelUserGenerated()
        bindViewModelError()
        
        bindGenerateButtonTap()
        bindSaveButtonTap()
        bindMoreInfoButtonTap()
    }
    
    private func bindViewModelUserGenerated() {
        _ = viewModel.observableUser.observeNext { generatedUser in
            guard let user = generatedUser else {
                return
            }
            self.userCardView.configure(user: user)
            self.userCardView.springShowing()
            self.activityIndicator.stopAnimating()
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    private func bindViewModelError() {
        _ = viewModel.observableError.observeNext { [unowned self] error in
            guard let error = error else {
                return
            }
            showError(text: error.localizedDescription) { cancelAction in
                activityIndicator.stopAnimating()
            } retryAction: { action in
                viewModel.generateUser()
            }
        }
    }
    
    private func bindGenerateButtonTap() {
        _ = navigationItem.rightBarButtonItem?.reactive.tap.observeNext {
            self.userCardView.springHiding()
            self.activityIndicator.startAnimating()
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            self.viewModel.generateUser()
        }
    }
    
    private func bindSaveButtonTap() {
        _ = userCardView.saveButton.reactive.tap.observeNext {
            self.userCardView.saveButton.toggle { selected in
                if selected {
                    self.viewModel.saveCurrentUser()
                } else {
                    self.viewModel.removeCurrentUser()
                }
            }
        }
    }
    
    private func bindMoreInfoButtonTap() {
        _ = userCardView.moreInfoButton.reactive.tap.observeNext {
            self.viewModel.showDetail()
        }
    }
}
