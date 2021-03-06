//
//  Animatable.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/30/20.
//

import UIKit

protocol Animatable: UIView { }

extension Animatable {
    
    func springShowing() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.9) {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.alpha = 1
        }
    }
    
    func springHiding() {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.9) {
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.alpha = 0
        }
    }
}
