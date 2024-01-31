//
//  TimeTapView.swift
//  DecisionToLeave
//
//  Created by 황홍필 on 2024/01/30.
//

import UIKit
import SnapKit

final class TimeTapView: UIView {
    
    // MARK: - Size Manager
    private let deviceSize = DeviceSizeManager.shared
    
    // MARK: - Data
    lazy var buttons: [UIButton] = [thirtyMinutes, oneHour, twoHour, threeHour]
    
    // MARK: - UI Components
    lazy var fingerTapImageView: UIImageView = {
        let imageView = UIImageView()
        let alarmConfig = UIImage.SymbolConfiguration(pointSize: deviceSize.adaptedSize(13), weight: .regular, scale: .medium)
        let alarmImage = UIImage(systemName: "hand.tap.fill", withConfiguration: alarmConfig)
        imageView.image = alarmImage
        imageView.tintColor = .decisionBorderGray
        return imageView
    }()
    
    lazy var fingerTapBorderView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.decisionBorderGray.cgColor
        view.layer.borderWidth = deviceSize.adaptedSize(2.0)
        view.layer.cornerRadius = deviceSize.adaptedSize(12.5)
        view.layer.masksToBounds = true
        view.backgroundColor = .decisionOrange
        return view
    }()
    
    lazy var thirtyMinutes: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = deviceSize.adaptedSize(2.0)
        button.layer.cornerRadius = deviceSize.adaptedSize(10)
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.decisionBorderGray.cgColor
        button.setTitle("30 Min", for: .normal)
        button.titleLabel?.font = .LINESeedRegular(size: deviceSize.adaptedSize(16))
        button.setTitleColor(.decisionBlack, for: .normal)
        button.backgroundColor = .decisionBackground
        return button
    }()
    
    lazy var oneHour: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = deviceSize.adaptedSize(2.0)
        button.layer.cornerRadius = deviceSize.adaptedSize(10)
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.decisionBorderGray.cgColor
        button.setTitle("1 Hour", for: .normal)
        button.titleLabel?.font = .LINESeedRegular(size: deviceSize.adaptedSize(16))
        button.setTitleColor(.decisionBlack, for: .normal)
        button.backgroundColor = .decisionBackground
        return button
    }()
    
    lazy var twoHour: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = deviceSize.adaptedSize(2.0)
        button.layer.cornerRadius = deviceSize.adaptedSize(10)
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.decisionBorderGray.cgColor
        button.setTitle("2 Hour", for: .normal)
        button.titleLabel?.font = .LINESeedRegular(size: deviceSize.adaptedSize(16))
        button.setTitleColor(.decisionBlack, for: .normal)
        button.backgroundColor = .decisionBackground
        return button
    }()
    
    lazy var threeHour: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = deviceSize.adaptedSize(2.0)
        button.layer.cornerRadius = deviceSize.adaptedSize(10)
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.decisionBorderGray.cgColor
        button.setTitle("3 Hour", for: .normal)
        button.titleLabel?.font = .LINESeedRegular(size: deviceSize.adaptedSize(16))
        button.setTitleColor(.decisionBlack, for: .normal)
        button.backgroundColor = .decisionBackground
        return button
    }()
    
    // MARK: - Stack
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [thirtyMinutes, oneHour, twoHour, threeHour])
        stack.axis = .horizontal
        stack.spacing = deviceSize.adaptedSize(12)
        stack.distribution = .fillEqually
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension TimeTapView: ViewDrawable {
    func configureUI() {
        setBackgroundColor()
        setAutolayout()
    }
    
    func setBackgroundColor() {
        self.backgroundColor = .decisionRetroBackground
    }
    
    func setAutolayout() {
        [stackView].forEach { self.addSubview($0) }

//        fingerTapImageView.snp.makeConstraints { make in
//            make.leading.equalTo(self.snp.leading).offset(self.deviceSize.adaptedSize(13))
//            make.top.equalTo(self.snp.top).offset(self.deviceSize.adaptedSize(13))
//        }
//
//        fingerTapBorderView.snp.makeConstraints { make in
//            make.center.equalTo(fingerTapImageView.snp.center)
//            make.width.height.equalTo(self.deviceSize.adaptedSize(25))
//        }
        
        stackView.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
        }
        
        thirtyMinutes.snp.makeConstraints { make in
            make.width.equalTo(self.deviceSize.adaptedSize(70))
            make.height.equalTo(self.deviceSize.adaptedSize(35))
        }
    }
}
