//
//  SaveOrNotAlertView.swift
//  DecisionToLeave
//
//  Created by 황홍필 on 2024/02/05.
//

import UIKit
import SnapKit

final class SaveOrNotAlertView: UIView {
    
    // MARK: - Size Manager
    private let deviceSize = DeviceSizeManager.shared
    
    // MARK: - UI Components
    private lazy var saveOrNotLabel: UILabel = {
        let label = UILabel()
        label.font = .LINESeedRegular(size: self.deviceSize.adaptedSize(17))
        label.text = "변경 사항을 저장하지 않고 /n 에디터를 종료하시겠습니까?"
        return label
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.decisionBlack, for: .normal)
        button.backgroundColor = .decisionBackground
        button.layer.borderColor = UIColor.decisionBorderGray.cgColor
        button.layer.borderWidth = self.deviceSize.adaptedSize(2.0)
        button.layer.cornerRadius = self.deviceSize.adaptedSize(20)
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var yesButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.decisionBackground, for: .normal)
        button.backgroundColor = .decisionPink
        button.layer.borderColor = UIColor.decisionBorderGray.cgColor
        button.layer.borderWidth = self.deviceSize.adaptedSize(2.0)
        button.layer.cornerRadius = self.deviceSize.adaptedSize(20)
        button.layer.masksToBounds = true
        return button
    }()
    
    // MARK: - Stack
    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cancelButton, yesButton])
        stack.axis = .horizontal
        stack.spacing = self.deviceSize.adaptedSize(15)
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [saveOrNotLabel, buttonStack])
        stack.axis = .vertical
        stack.spacing = self.deviceSize.adaptedSize(15)
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

extension SaveOrNotAlertView: ViewDrawable {
    func configureUI() {
        setBackgroundColor()
        setAutolayout()
    }
    
    func setBackgroundColor() {
        self.backgroundColor = .decisionRetroBackground
    }
    
    func setAutolayout() {
        [stackView].forEach { self.addSubview($0) }
        
        stackView.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.width.equalTo(self.deviceSize.adaptedSize(60))
            make.height.equalTo(self.deviceSize.adaptedSize(40))
        }
        
    }
}
