//
//  InfoStackView.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/31/20.
//

import Foundation
import UIKit

class InfoStackView: UIView {
    var phone: String = "" {
        didSet { phoneInfoView.valueLabel.text = phone }
    }
    var location: String = "" {
        didSet { locationInfoView.valueLabel.text = location }
    }
    var dateBirth: String = "" {
        didSet { dateBirthInfoView.valueLabel.text = dateBirth }
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var phoneInfoView: InfoFieldView = {
        let view = InfoFieldView(icon: UIImage(systemName: "phone.fill")!, title: "Phone")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var locationInfoView: InfoFieldView = {
        let view = InfoFieldView(icon: UIImage(systemName: "location.fill")!, title: "Location")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dateBirthInfoView: InfoFieldView = {
        let view = InfoFieldView(icon: UIImage(systemName: "gift.fill")!, title: "Date of Birth")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupSubviews() {
        addSubview(phoneInfoView)
        addSubview(locationInfoView)
        addSubview(dateBirthInfoView)
    }
    
    private func setupView() {
        setupSubviews()
        
        phoneInfoView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
        locationInfoView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(phoneInfoView.snp.bottom)
        }
        dateBirthInfoView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(locationInfoView.snp.bottom)
        }
    }
}
