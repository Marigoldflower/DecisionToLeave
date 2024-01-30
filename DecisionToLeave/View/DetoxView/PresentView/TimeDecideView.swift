//
//  TimeDecideView.swift
//  DecisionToLeave
//
//  Created by 황홍필 on 2024/01/30.
//

import UIKit
import SnapKit

final class TimeDecideView: UIView {
    
    // MARK: - Size Manager
    let deviceSize = DeviceSizeManager.shared
    
    // MARK: - UI Components
    lazy var alarmImageView: UIImageView = {
        let imageView = UIImageView()
        let alarmConfig = UIImage.SymbolConfiguration(pointSize: deviceSize.adaptedSize(15), weight: .regular, scale: .medium)
        let alarmImage = UIImage(systemName: "alarm", withConfiguration: alarmConfig)
        imageView.image = alarmImage
        imageView.tintColor = .decisionBorderGray
        return imageView
    }()
    
    lazy var alarmBorderView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.decisionBorderGray.cgColor
        view.layer.borderWidth = deviceSize.adaptedSize(2.0)
        view.layer.cornerRadius = deviceSize.adaptedSize(12.5)
        view.layer.masksToBounds = true
        view.backgroundColor = .decisionGreen
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .LINESeedRegular(size: self.deviceSize.adaptedSize(13))
        label.text = "시간 설정"
        label.textColor = .decisionBorderGray
        return label
    }()
    
    private lazy var timeDecideLabel: UILabel = {
        let label = UILabel()
        label.font = .DIGI(size: self.deviceSize.adaptedSize(50))
        label.text = "00:00"
        label.textColor = .decisionBlack
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension TimeDecideView: ViewDrawable {
    func configureUI() {
        setBackgroundColor()
        setAutolayout()
    }
    
    func setBackgroundColor() {
        self.backgroundColor = .decisionRetroBackground
    }
    
    func setAutolayout() {
        
        [alarmImageView, alarmBorderView, descriptionLabel, timeDecideLabel].forEach { self.addSubview($0) }

        alarmImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(self.deviceSize.adaptedSize(10))
            make.top.equalTo(self.snp.top).offset(self.deviceSize.adaptedSize(10))
        }

        alarmBorderView.snp.makeConstraints { make in
            make.center.equalTo(alarmImageView.snp.center)
            make.width.height.equalTo(self.deviceSize.adaptedSize(25))
        }

        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(alarmBorderView.snp.trailing).offset(self.deviceSize.adaptedSize(8))
            make.centerY.equalTo(alarmImageView.snp.centerY)
        }

        timeDecideLabel.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
        }
    }
}
