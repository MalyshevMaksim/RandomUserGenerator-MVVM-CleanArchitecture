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

    private var viewModelInput: SavedUserViewModelInput
    private var viewModelOutput: SavedUserViewModelOutput
    
    var delegate: UITableViewDelegate!
    
    init(input: SavedUserViewModelInput, output: SavedUserViewModelOutput) {
        self.viewModelInput = input
        self.viewModelOutput = output
        self.delegate = SavedUserTableViewDelegate(input: viewModelInput)
        super.init(nibName: nil, bundle: nil)
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
        viewModelOutput.observableUsers.bind(to: tableView) { dataSource, indexPath, tableView in
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
        viewModelInput.search(with: searchController.searchBar.text)
    }
}
