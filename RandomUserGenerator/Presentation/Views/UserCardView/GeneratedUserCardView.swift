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
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 70
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var moreInfoButton: UIButton = {
        let button = UIButton(type: .detailDisclosure)
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
    
    func configure(user: User) {
        DispatchQueue.main.async {
            self.springShowing(willShowingCompletion: {
                self.name.text = user.name?.fullName
                self.email.text = user.email
                self.infoStack.phone = user.phone
                self.infoStack.location = user.location!.fullLocation
                self.infoStack.dateBirth = user.dob!.formattedDate
                self.poster.image = UIImage(data: (user.picture?.data)!)
                self.toggle = true
                self.saveButtonUnable()
            })
        }
    }
    
    var toggle = false
    
    func saveButtonUnable() {
        toggle.toggle()
        
        DispatchQueue.main.async {
            if self.toggle {
                self.saveButton.backgroundColor = .systemRed
                self.saveButton.setTitle("Delete", for: .normal)
            } else {
                self.saveButton.backgroundColor = .systemBlue
                self.saveButton.setTitle("Save", for: .normal)
            }
        }
    }
    
    private func setupSubviews() {
        addSubview(background)
        background.addSubview(poster)
        background.addSubview(name)
        background.addSubview(email)
        background.addSubview(divider)
        background.addSubview(saveButton)
        background.addSubview(infoStack)
        background.addSubview(moreInfoButton)
        self.alpha = 0
    }
    
    private func setupView() {
        setupSubviews()
        
        background.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        poster.snp.makeConstraints {
            $0.width.height.equalTo(background.snp.height).multipliedBy(0.25)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(40)
        }
        
        name.snp.makeConstraints {
            $0.top.equalTo(poster.snp.bottom).inset(-25)
            $0.centerX.equalToSuperview()
        }
        
        email.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(name.snp.bottom).inset(-5)
        }
        
        divider.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.85)
            $0.height.equalTo(0.5)
            $0.centerX.equalToSuperview  ()
            $0.top.equalTo(email.snp.bottom).inset(-25)
        }
        
        saveButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.85)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().multipliedBy(0.95)
        }
        
        infoStack.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.85)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(divider.snp.bottom)
            $0.height.equalTo(150)
        }
        
        moreInfoButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(25)
        }
    }
}
