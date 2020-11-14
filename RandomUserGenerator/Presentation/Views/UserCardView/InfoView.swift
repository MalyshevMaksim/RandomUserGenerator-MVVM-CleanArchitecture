//
//  InfoView.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/30/20.
//

import Foundation
import UIKit

class InfoFieldView: UIView {
    private var icon: UIImageView = UIImageView()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var divider: UIView = {
        let devider = UIView()
        devider.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.25)
        return devider
    }()
    
    init(icon: UIImage, title: String) {
        self.icon.image = icon
        super.init(frame: .zero)
        self.title.text = title
        setupStack()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(icon)
        addSubview(title)
        addSubview(valueLabel)
        addSubview(divider)
    }
    
    private func setupStack() {
        setupSubviews()
        
        icon.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        title.snp.makeConstraints {
            $0.leading.equalTo(icon.snp.trailing).inset(-10)
            $0.centerY.equalToSuperview()
        }
        
        valueLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        divider.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(0.5)
            $0.bottom.equalToSuperview()
        }
    }
}
