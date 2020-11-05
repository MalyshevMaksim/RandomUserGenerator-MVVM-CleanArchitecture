//
//  UserCell.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/5/20.
//

import Foundation
import UIKit
import SnapKit

class UserCell: UITableViewCell {
    static var reuseIdentifier = "UserCell"
    
    func configure(user: User) {
        DispatchQueue.main.async {
            self.name.text = user.name?.fullName
            self.email.text = user.email
            self.phone.text = user.phone
        }
    }
    
    lazy var name: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var email: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var phone: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var phoneStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(UIImageView(image: UIImage(systemName: "phone")))
        stack.addArrangedSubview(phone)
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var emailStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(UIImageView(image: UIImage(systemName: "envelope")))
        stack.addArrangedSubview(email)
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var poster: UIImageView = {
        let poster = UIImageView()
        poster.image = UIImage(named: "user")
        poster.layer.cornerRadius = 5
        poster.clipsToBounds = true
        poster.translatesAutoresizingMaskIntoConstraints = false
        return poster
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(poster)
        contentView.addSubview(name)
        contentView.addSubview(emailStack)
        contentView.addSubview(phoneStack)
    }
    
    private func setupCell() {
        setupSubviews()
        
        poster.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(16)
            make.height.equalTo(85)
            make.width.equalTo(85)
        }
        name.snp.makeConstraints { make in
            make.leading.equalTo(poster.snp.trailing).inset(-10)
            make.top.equalTo(poster)
        }
        emailStack.snp.makeConstraints { make in
            make.leading.equalTo(name)
            make.top.equalTo(name.snp.bottom).inset(-10)
        }
        phoneStack.snp.makeConstraints { make in
            make.leading.equalTo(name)
            make.top.equalTo(emailStack.snp.bottom).inset(-10)
        }
        contentView.snp.makeConstraints { make in
            make.height.equalTo(115)
        }
    }
}
