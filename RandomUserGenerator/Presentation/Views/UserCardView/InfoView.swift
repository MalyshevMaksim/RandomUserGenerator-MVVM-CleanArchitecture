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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var divider: UIView = {
        let devider = UIView()
        devider.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.25)
        devider.translatesAutoresizingMaskIntoConstraints = false
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
        icon.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        title.snp.makeConstraints { make in
            make.leading.equalTo(icon.snp.trailing).inset(-10)
            make.centerY.equalToSuperview()
        }
        valueLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        divider.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(0.5)
            make.bottom.equalToSuperview()
        }
    }
}
