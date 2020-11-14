//
//  HorizontalStackView.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/14/20.
//

import UIKit
import SnapKit

class HorizontalStackView: UIView {
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        return icon
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var stack: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(icon)
        stackView.addArrangedSubview(label)
        stackView.spacing = 5
        return stackView
    }()
    
    init(icon: UIImage) {
        super.init(frame: .zero)
        self.icon.image = icon
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(stack)
        
        stack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
