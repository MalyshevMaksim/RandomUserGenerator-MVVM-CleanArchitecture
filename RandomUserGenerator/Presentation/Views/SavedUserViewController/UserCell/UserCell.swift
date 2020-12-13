//
//  UserCell.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/5/20.
//

import UIKit
import SnapKit

class UserCell: UITableViewCell {
    static var reuseIdentifier = "UserCell"
    
    private lazy var name: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private lazy var emailStack: HorizontalStackView = {
        let stack = HorizontalStackView(icon: UIImage(systemName: "envelope")!)
        return stack
    }()
    
    private lazy var phoneStack: HorizontalStackView = {
        let stack = HorizontalStackView(icon: UIImage(systemName: "phone")!)
        return stack
    }()
    
    private lazy var poster: UIImageView = {
        let poster = UIImageView()
        poster.layer.cornerRadius = 5
        poster.clipsToBounds = true
        return poster
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(user: User) {
        DispatchQueue.main.async {
            self.name.text = user.name?.fullName
            self.emailStack.label.text = user.email
            self.phoneStack.label.text = user.phone
            //self.poster.image = UIImage(data: (user.picture?.data)!)
            self.accessoryType = .disclosureIndicator
        }
    }
    
    private func setupSubviews() {
        contentView.addSubview(poster)
        contentView.addSubview(name)
        contentView.addSubview(emailStack)
        contentView.addSubview(phoneStack)
    }
    
    private func setupCell() {
        setupSubviews()
        
        poster.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(safeAreaInsets).inset(16)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(contentView.snp.height).multipliedBy(0.75)
        }
        
        name.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).inset(10)
            $0.leading.equalTo(poster.snp.trailing).inset(-10)
        }
        
        emailStack.snp.makeConstraints {
            $0.leading.equalTo(name)
            $0.top.equalTo(name.snp.bottom).inset(-10)
        }
        
        phoneStack.snp.makeConstraints {
            $0.leading.equalTo(name)
            $0.top.equalTo(emailStack.snp.bottom).inset(-10)
        }
    }
}
