//
//  SavedUserViewController.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/4/20.
//

import Foundation
import UIKit
import Bond
import RealmSwift

class SavedUserViewController: UITableViewController {

    var viewModel: SavedUserViewModel!
    var delegate: UITableViewDelegate!
    
    init(viewModel: SavedUserViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.delegate = SavedUserTableViewDelegate(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
        configureNavigation()
        bindViewModelSearch()
    }
    
    private func configureTableView() {
        tableView.delegate = delegate
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func configureNavigation() {
        title = "Saved"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = UISearchController()
        navigationItem.searchController?.searchResultsUpdater = self
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
    }
    
    private func bindViewModelSearch() {
        viewModel.observableUsers.bind(to: tableView) { dataSource, indexPath, tableView in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseIdentifier, for: indexPath) as? UserCell else {
                return UITableViewCell()
            }
            let user = dataSource[indexPath.row]
            cell.configure(user: user)
            return cell
        }
    }
}

extension SavedUserViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.search(with: searchController.searchBar.text)
    }
}
