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
        configureNavigation()
        bind()
        viewModel.executeFetchUseCase()
    }
    
    private func configureNavigation() {
        title = "Saved"
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.reuseIdentifier)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = UISearchController()
    }
    
    private func bind() {
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
}
