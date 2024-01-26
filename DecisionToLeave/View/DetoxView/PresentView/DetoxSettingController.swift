//
//  DetoxSettingController.swift
//  DecisionToLeave
//
//  Created by 황홍필 on 2024/01/25.
//

import UIKit
import SnapKit

final class DetoxSettingController: UIViewController {
    
    // MARK: - Vibrate Manager
    private let deviceVibrate = DeviceVibrateManager.shared
    
    // MARK: - Size Manager
    private let deviceSize = DeviceSizeManager.shared

    // 시간 설정 탭을 만들어야 함
    // 1. 30분, 1시간, 2시간, 3시간 단위의 버튼 4개를 만들기
    // 2. 더 큰 단위의 시간은 UIDatePicker로 설정하기
    // 3. 시간 설정하기 버튼 만들기 
    
    // MARK: - UI Components
    private lazy var lockThePhoneSettingLabel: UILabel = {
        let label = UILabel()
        label.font = .LINESeedBold(size: self.deviceSize.adaptedSize(23))
        label.text = "휴대폰 잠금 설정"
        label.textColor = .decisionBlack
        return label
    }()
    
    
   
    private lazy var createTimeSettingButton: UIButton = {
        let button = UIButton()
        button.setTitle("시간 설정하기", for: .normal)
        button.titleLabel?.font = .LINESeedRegular(size: self.deviceSize.adaptedSize(19))
        button.setTitleColor(.decisionBlack, for: .normal)
        button.layer.borderColor = UIColor.decisionBorderGray.cgColor
        button.layer.borderWidth = self.deviceSize.adaptedSize(2.0)
        button.layer.cornerRadius = self.deviceSize.adaptedSize(30)
        button.layer.masksToBounds = true
        button.backgroundColor = .decisionSkyBlue
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

extension DetoxSettingController: ViewDrawable {
    func configureUI() {
        setBackgroundColor()
        setAutolayout()
    }
    
    func setBackgroundColor() {
        view.backgroundColor = .decisionBackground
    }
    
    func setAutolayout() {
        [lockThePhoneSettingLabel, createTimeSettingButton].forEach { view.addSubview($0) }
        
        lockThePhoneSettingLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(self.deviceSize.adaptedSize(30))
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(self.deviceSize.adaptedSize(30))
        }
        
        createTimeSettingButton.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(self.deviceSize.adaptedSize(30))
            make.trailing.equalTo(view.snp.trailing).offset(self.deviceSize.adaptedSize(-30))
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(self.deviceSize.adaptedSize(-30))
            make.height.equalTo(self.deviceSize.adaptedSize(60))
        }
    }
}
