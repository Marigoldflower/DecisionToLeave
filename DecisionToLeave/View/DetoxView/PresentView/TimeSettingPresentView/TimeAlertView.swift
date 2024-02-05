//
//  TimeScrollView.swift
//  DecisionToLeave
//
//  Created by 황홍필 on 2024/01/31.
//

import UIKit
import SnapKit


final class TimeAlertView: UIView {
    
    // MARK: - Size Manager
    private let deviceSize = DeviceSizeManager.shared
    
    // MARK: - UI Components
    lazy var alertImageView: UIImageView = {
        let imageView = UIImageView()
        let alarmConfig = UIImage.SymbolConfiguration(pointSize: deviceSize.adaptedSize(13), weight: .regular, scale: .medium)
        let alarmImage = UIImage(systemName: "bell.fill", withConfiguration: alarmConfig)
        imageView.image = alarmImage
        imageView.tintColor = .decisionBorderGray
        return imageView
    }()
    
    lazy var alertBorderView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.decisionBorderGray.cgColor
        view.layer.borderWidth = deviceSize.adaptedSize(2.0)
        view.layer.cornerRadius = deviceSize.adaptedSize(12.5)
        view.layer.masksToBounds = true
        view.backgroundColor = .decisionOrange
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

extension TimeAlertView: ViewDrawable {
    func configureUI() {
        setBackgroundColor()
        setAutolayout()
    }
    
    func setBackgroundColor() {
        self.backgroundColor = .decisionRetroBackground
    }
    
    func setAutolayout() {
        [alertImageView, alertBorderView].forEach { self.addSubview($0) }
        
        alertImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(self.deviceSize.adaptedSize(13))
            make.top.equalTo(self.snp.top).offset(self.deviceSize.adaptedSize(13))
        }
        
        alertBorderView.snp.makeConstraints { make in
            make.center.equalTo(alertImageView.snp.center)
            make.width.height.equalTo(self.deviceSize.adaptedSize(25))
        }
    }
}
