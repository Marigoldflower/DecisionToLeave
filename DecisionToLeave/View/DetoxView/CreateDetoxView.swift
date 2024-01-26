//
//  CreateDetoxView.swift
//  DecisionToLeave
//
//  Created by 황홍필 on 2024/01/25.
//

import UIKit
import SnapKit

final class CreateDetoxView: UIView {
    
    // MARK: - Size Manager
    let deviceSize = DeviceSizeManager.shared
    
    // MARK: - UI Components
    private lazy var plusImageView: UIImageView = {
        let imageView = UIImageView()
        let plusConfig = UIImage.SymbolConfiguration(pointSize: deviceSize.adaptedSize(40), weight: .regular, scale: .medium)
        let plusImage = UIImage(systemName: "plus.circle.fill", withConfiguration: plusConfig)
        imageView.image = plusImage
        imageView.tintColor = .decisionYellow
        return imageView
    }()
    
    private lazy var plusImageBorder: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.decisionBorderGray.cgColor
        view.layer.borderWidth = deviceSize.adaptedSize(2.0)
        view.layer.cornerRadius = deviceSize.adaptedSize(20)
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var horizontalView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.decisionBorderGray.cgColor
        view.layer.borderWidth = deviceSize.adaptedSize(2.0)
        view.layer.cornerRadius = deviceSize.adaptedSize(1.5)
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var verticalView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.decisionBorderGray.cgColor
        view.layer.borderWidth = deviceSize.adaptedSize(2.0)
        view.layer.cornerRadius = deviceSize.adaptedSize(1.5)
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .LINESeedRegular(size: deviceSize.adaptedSize(16))
        label.textColor = .decisionBlack
        label.text = "버튼을 눌러 휴대폰 잠금 설정을 추가해주세요"
        return label
    }()
    
    // MARK: - Stack
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [plusImageView, descriptionLabel])
        stack.axis = .vertical
        stack.spacing = deviceSize.adaptedSize(15)
        stack.alignment = .center
        stack.distribution = .fill
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

extension CreateDetoxView: ViewDrawable {
    func configureUI() {
        setBackgroundColor()
        setAutolayout()
    }
    
    func setBackgroundColor() {
        self.backgroundColor = .decisionRetroBackground
    }
    
    func setAutolayout() {
        [stackView, plusImageBorder, horizontalView, verticalView].forEach { self.addSubview($0) }
        
        stackView.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
        }
        
        plusImageBorder.snp.makeConstraints { make in
            make.width.height.equalTo(deviceSize.adaptedSize(40))
            make.center.equalTo(plusImageView.snp.center)
        }
        
        horizontalView.snp.makeConstraints { make in
            make.width.equalTo(deviceSize.adaptedSize(20))
            make.height.equalTo(deviceSize.adaptedSize(3))
            make.center.equalTo(plusImageView.snp.center)
        }
        
        verticalView.snp.makeConstraints { make in
            make.width.equalTo(deviceSize.adaptedSize(3))
            make.height.equalTo(deviceSize.adaptedSize(20))
            make.center.equalTo(plusImageView.snp.center)
        }
    }
}
