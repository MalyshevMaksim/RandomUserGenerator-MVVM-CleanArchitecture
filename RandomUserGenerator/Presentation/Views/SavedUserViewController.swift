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
    var viewModel: SavedUserViewModel!
    
    init(viewModel: SavedUserViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.reuseIdentifier)
        configureNavigation()
        bindViewModelSearch()
        bindDidSelectRow()
    }

    private func configureNavigation() {
        title = "Saved"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = UISearchController()
        navigationItem.searchController?.searchResultsUpdater = self
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
    }
    
    private func bindDidSelectRow() {
        _ = tableView.reactive.selectedRowIndexPath.observeNext { indexPath in
            self.viewModel.showDetail(for: indexPath)
        }
    }
}

extension SavedUserViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.executeSearchUseCase(searchText: searchController.searchBar.text)
    }
    
    private func bindViewModelSearch() {
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
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let contextAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, _ in
            self.viewModel.executeRemoveUseCase(indexPath: indexPath)
        }
        contextAction.image = UIImage(systemName: "trash.fill")
        return UISwipeActionsConfiguration(actions: [contextAction])
    }
}
