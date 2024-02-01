//
//  TimeScrollView.swift
//  DecisionToLeave
//
//  Created by 황홍필 on 2024/01/31.
//

import UIKit
import SnapKit


final class TimeScrollView: UIView {
    
    // MARK: - Size Manager
    private let deviceSize = DeviceSizeManager.shared
    
    // MARK: - UI Components
    lazy var scrollImageView: UIImageView = {
        let imageView = UIImageView()
        let alarmConfig = UIImage.SymbolConfiguration(pointSize: deviceSize.adaptedSize(13), weight: .regular, scale: .medium)
        let alarmImage = UIImage(systemName: "scroll.fill", withConfiguration: alarmConfig)
        imageView.image = alarmImage
        imageView.tintColor = .decisionBorderGray
        return imageView
    }()
    
    lazy var scrollBorderView: UIView = {
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

extension TimeScrollView: ViewDrawable {
    func configureUI() {
        setBackgroundColor()
        setAutolayout()
    }
    
    func setBackgroundColor() {
        self.backgroundColor = .decisionRetroBackground
    }
    
    func setAutolayout() {
        [scrollImageView, scrollBorderView].forEach { self.addSubview($0) }
        
        scrollImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(self.deviceSize.adaptedSize(13))
            make.top.equalTo(self.snp.top).offset(self.deviceSize.adaptedSize(13))
        }
        
        scrollBorderView.snp.makeConstraints { make in
            make.center.equalTo(scrollImageView.snp.center)
            make.width.height.equalTo(self.deviceSize.adaptedSize(25))
        }
    }
}
