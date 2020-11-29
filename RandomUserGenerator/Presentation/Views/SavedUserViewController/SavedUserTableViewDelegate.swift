//
//  SavedUserTableViewDelegate.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/29/20.
//

import UIKit

class SavedUserTableViewDelegate: NSObject, UITableViewDelegate {
    
    private var viewModel: SavedUserViewModel
    
    init(viewModel: SavedUserViewModel) {
        self.viewModel = viewModel
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let contextAction = UIContextualAction(style: .destructive, title: nil) { action, view, _ in
            self.viewModel.remove(from: indexPath)
        }
        contextAction.image = UIImage(systemName: "trash.fill")
        return UISwipeActionsConfiguration(actions: [contextAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showDetail(for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
}
