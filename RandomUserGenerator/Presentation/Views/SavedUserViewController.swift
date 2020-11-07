//
//  SavedUserViewController.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/4/20.
//

import Foundation
import UIKit
import Bond

class SavedUserViewController: UITableViewController {
    var viewModel = SavedUserViewModel(fetchUseCase: FetchUserInteractor(usersRepository: UsersPersistentRepository(storage: UsersRealmStorage()), picturesRepository: PicturesPersistentRepository(storage: PicturesRealmStorage())))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.reuseIdentifier)
        configureNavigation()
        bindViewModelUsers()
        viewModel.executeFetchUseCase()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bindViewModelPictures()
    }
    
    private func configureNavigation() {
        title = "Saved"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = UISearchController()
    }
    
    private func bindViewModelUsers() {
        viewModel.observableUsers.bind(to: tableView) { dataSource, indexPath, tableView in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseIdentifier, for: indexPath) as? UserCell else {
                return UITableViewCell()
            }
            cell.accessoryType = .detailDisclosureButton
            let user = dataSource[indexPath.row]
            cell.configure(user: user)
            return cell
        }
    }
    
    private func bindViewModelPictures() {
        viewModel.observablePictures.bind(to: tableView, cellType: UserCell.self) { cell, image in
            DispatchQueue.main.async {
                cell.poster.image = image
            }
        }
    }
}
