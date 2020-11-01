//
//  GeneratedUserView.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/29/20.
//

import Foundation
import UIKit
import SnapKit

class GeneratedUserCardView: UIView, Animatable {
    func configure(user: User, completion: (Bool) -> ()) {
        guard let user = user.results.first else {
            completion(false)
            return
        }
        springShowing(willShowingCompletion: {
            self.name.text = user.name?.fullName
            self.email.text = user.email
            self.infoStack.phone = user.phone
            self.infoStack.location = user.location!.fullLocation
            self.infoStack.dateBirth = user.dob!.formattedDate
        })
        completion(true)
    }
    
    private lazy var name: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var email: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var poster: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "user"))
        imageView.layer.cornerRadius = 70
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var background: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .secondarySystemBackground
        view.layer.shadowRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 20
        return view
    }()
    
    private lazy var divider: UIView = {
        let devider = UIView()
        devider.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.25)
        devider.translatesAutoresizingMaskIntoConstraints = false
        return devider
    }()
    
    private lazy var infoStack: InfoStackView = {
        let stack = InfoStackView()
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(background)
        background.addSubview(poster)
        background.addSubview(name)
        background.addSubview(email)
        background.addSubview(divider)
        background.addSubview(saveButton)
        background.addSubview(infoStack)
        self.alpha = 0
    }
    
    private func setupView() {
        setupSubviews()
        background.snp.makeConstraints { make in make.edges.equalTo(safeAreaLayoutGuide).inset(16) }
        poster.snp.makeConstraints { make in
            make.width.height.equalTo(background.snp.height).multipliedBy(0.25)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(poster.frame.height * 0.2)
        }
        name.snp.makeConstraints { make in
            make.top.equalTo(poster.snp.bottom).inset(-25)
            make.centerX.equalToSuperview()
        }
        email.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(name.snp.bottom).inset(-5)
        }
        divider.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.85)
            make.height.equalTo(0.5)
            make.centerX.equalToSuperview  ()
            make.top.equalTo(email.snp.bottom).inset(-25)
        }
        saveButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.85)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().multipliedBy(0.95)
        }
        infoStack.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.85)
            make.centerX.equalToSuperview()
            make.top.equalTo(divider.snp.bottom)
            make.height.equalTo(150)
        }
    }
}
