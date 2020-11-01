//
//  Alertable.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/30/20.
//

import Foundation
import UIKit

protocol Alertable: UIViewController { }

extension Alertable {
    
    func showError(text: String, cancelAction: ((UIAlertAction)->Void)? = nil, retryAction: ((UIAlertAction)->Void)? = nil) {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: cancelAction))
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: retryAction))
        present(alert, animated: true, completion: nil)
    }
}
