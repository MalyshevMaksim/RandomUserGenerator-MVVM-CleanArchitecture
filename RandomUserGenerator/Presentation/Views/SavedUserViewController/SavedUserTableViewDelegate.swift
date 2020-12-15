//
//  SavedUserTableViewDelegate.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/29/20.
//

import UIKit

class SavedUserTableViewDelegate: NSObject, UITableViewDelegate {
    
    private var viewModelInput: SavedUserViewModelInput
    
    init(input: SavedUserViewModelInput) {
        self.viewModelInput = input
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let contextAction = UIContextualAction(style: .destructive, title: nil) { action, view, _ in
            self.viewModelInput.remove(from: indexPath)
        }
        contextAction.image = UIImage(systemName: "trash.fill")
        return UISwipeActionsConfiguration(actions: [contextAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModelInput.showDetail(for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
}
