//
//  Animatable.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/30/20.
//

import Foundation
import UIKit

protocol Animatable: UIView { }

extension Animatable {
    
    func springShowing(willShowingCompletion: (()->())? = nil) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.9) {
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.alpha = 0
        } completion: { _ in
            if let completion = willShowingCompletion {
                completion()
            }
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.9) {
                self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.alpha = 1
            }
        }
    }
}
