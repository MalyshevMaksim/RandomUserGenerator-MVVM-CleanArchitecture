//
//  SaveToggleButton.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/14/20.
//

import UIKit

class SaveToggleButton: UIButton {
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = .systemRed
                setTitle("Delete", for: .normal)
            }
            else {
                backgroundColor = .systemBlue
                setTitle("Save", for: .normal)
            }
        }
    }
    
    func toggle(completion: (Bool) -> ()) {
        isSelected.toggle()
        completion(isSelected)
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        isSelected = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
