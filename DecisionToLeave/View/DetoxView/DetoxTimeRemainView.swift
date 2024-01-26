//
//  DetoxTimeRemainView.swift
//  DecisionToLeave
//
//  Created by 황홍필 on 2024/01/25.
//

import UIKit
import SnapKit

final class DetoxTimeRemainView: UIView {
    
    // MARK: - Size Manager
    let deviceSize = DeviceSizeManager.shared
    
    // MARK: - UI Components
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .LINESeedRegular(size: deviceSize.adaptedSize(25))
        label.text = "남은 시간은"
        label.textColor = .decisionBorderGray
        return label
    }()
    
    private lazy var timeRemained: UILabel = {
        let label = UILabel()
        label.font = .LINESeedRegular(size: deviceSize.adaptedSize(50))
        label.text = "00 : 00"
        label.textColor = .decisionBlack
        return label
    }()
    
    // MARK: - Stack
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [descriptionLabel, timeRemained])
        stack.axis = .vertical
        stack.spacing = 30
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

extension DetoxTimeRemainView: ViewDrawable {
    func configureUI() {
        setBackgroundColor()
        setAutolayout()
    }
    
    func setBackgroundColor() {
        self.backgroundColor = .decisionYellow
    }
    
    func setAutolayout() {
        [stackView].forEach { self.addSubview($0) }
        
        stackView.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
        }
    }
}
