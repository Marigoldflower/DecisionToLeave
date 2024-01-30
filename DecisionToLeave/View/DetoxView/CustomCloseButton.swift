//
//  CustomCloseButton.swift
//  DecisionToLeave
//
//  Created by 황홍필 on 2024/01/29.
//

import UIKit
import SnapKit

protocol CustomCloseButtonDelegate: AnyObject {
    func closeButtonTapped()
}

final class CustomCloseButton: UIView {
    
    // MARK: - Size Manager
    let deviceSize = DeviceSizeManager.shared
    
    // MARK: - Delegate
    weak var delegate: CustomCloseButtonDelegate?
    
    // MARK: - UI Components
    lazy var closeButton: UIButton = {
        let button = UIButton()
        let closeConfig = UIImage.SymbolConfiguration(pointSize: deviceSize.adaptedSize(25), weight: .regular, scale: .medium)
        let closeImage = UIImage(systemName: "xmark.circle.fill", withConfiguration: closeConfig)
        button.setImage(closeImage, for: .normal)
        button.tintColor = .decisionPink
        return button
    }()

    lazy var closeButtonBorder: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.decisionBorderGray.cgColor
        view.layer.borderWidth = deviceSize.adaptedSize(2.0)
        view.layer.cornerRadius = deviceSize.adaptedSize(14.5)
        view.layer.masksToBounds = true
        view.backgroundColor = .decisionBorderGray
        return view
    }()
    
    private lazy var xMarkHeadingToLeft: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.decisionBorderGray.cgColor
        view.layer.borderWidth = deviceSize.adaptedSize(2.0)
        view.layer.cornerRadius = deviceSize.adaptedSize(1.5)
        view.layer.masksToBounds = true
        view.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / deviceSize.adaptedSize(4))
        return view
    }()
    
    private lazy var xMarkHeadingToRight: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.decisionBorderGray.cgColor
        view.layer.borderWidth = deviceSize.adaptedSize(2.0)
        view.layer.cornerRadius = deviceSize.adaptedSize(1.5)
        view.layer.masksToBounds = true
        view.transform = CGAffineTransform(rotationAngle: CGFloat.pi / deviceSize.adaptedSize(4))
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}

extension CustomCloseButton: ViewDrawable {
    func configureUI() {
        setBackgroundColor()
        setAutolayout()
    }
    
    func setBackgroundColor() {
        self.backgroundColor = .decisionRetroBackground
    }
    
    func setAutolayout() {
        [closeButton, closeButtonBorder, xMarkHeadingToLeft, xMarkHeadingToRight].forEach { self.addSubview($0) }
        
        closeButton.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
        }
        
        closeButtonBorder.snp.makeConstraints { make in
            make.center.equalTo(closeButton.snp.center)
            make.width.height.equalTo(deviceSize.adaptedSize(29))
        }
        
        xMarkHeadingToLeft.snp.makeConstraints { make in
            make.center.equalTo(closeButton.snp.center)
            make.width.equalTo(deviceSize.adaptedSize(3))
            make.height.equalTo(deviceSize.adaptedSize(14))
        }
        
        xMarkHeadingToRight.snp.makeConstraints { make in
            make.center.equalTo(closeButton.snp.center)
            make.width.equalTo(deviceSize.adaptedSize(3))
            make.height.equalTo(deviceSize.adaptedSize(14))
        }
        
    }
    
}
