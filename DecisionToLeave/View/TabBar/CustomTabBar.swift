//
//  CustomTabBar.swift
//  DecisionToLeave
//
//  Created by 황홍필 on 2024/01/19.
//

import UIKit
import SnapKit
import ReactorKit
import RxCocoa

final class CustomTabBar: UIView, View {
    
    // MARK: - Generator
    let generator = UIImpactFeedbackGenerator(style: .soft)
    
    // MARK: - Size Manager
    let deviceSize = DeviceSizeManager.shared
    
    // MARK: - DisposeBag
    var disposeBag = DisposeBag()
    
    // MARK: - ViewModel
    private let customTabBarViewModel = CustomTabBarViewModel()
    
    // MARK: - UI Components
    lazy var detoxTab: UIButton = {
        let button = UIButton()
        let buttonConfig = UIImage.SymbolConfiguration(pointSize: self.deviceSize.adaptedSize(20), weight: .regular, scale: .medium)
        let detoxImage = UIImage(systemName: "hand.raised.slash.fill", withConfiguration: buttonConfig)
        button.setImage(detoxImage, for: .normal)
        button.tintColor = .decisionBlack
        return button
    }()
    
    lazy var settingTab: UIButton = {
        let button = UIButton()
        let buttonConfig = UIImage.SymbolConfiguration(pointSize: self.deviceSize.adaptedSize(20), weight: .regular, scale: .medium)
        let rankingImage = UIImage(systemName: "gearshape.fill", withConfiguration: buttonConfig)
        button.setImage(rankingImage, for: .normal)
        button.tintColor = .decisionBlack
        return button
    }()
    
    lazy var selectedCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .decisionPink
        view.layer.borderColor = UIColor.decisionBorderGray.cgColor
        view.layer.borderWidth = self.deviceSize.adaptedSize(2.0)
        view.layer.cornerRadius = self.deviceSize.adaptedSize(22)
        view.layer.masksToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        reactor = customTabBarViewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

extension CustomTabBar: Bindable {
    func bind(reactor: CustomTabBarViewModel) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    func bindAction(_ reactor: Reactor) {
        detoxTab.rx.tap
            .map { CustomTabBarViewModel.Action.detoxTabTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        settingTab.rx.tap
            .map { CustomTabBarViewModel.Action.rankingTabTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    func bindState(_ reactor: Reactor) {
        reactor.state
            .map { $0.detoxControllerPresented }
            .subscribe(onNext: { [weak self] detoxTabIsTapped in
                if detoxTabIsTapped {
                    NotificationCenter.default.post(name: NSNotification.Name("ChangeTab"), object: nil, userInfo: ["tab": 0])
                    self?.generator.impactOccurred()
                }
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.rankingControllerPresented }
            .subscribe(onNext: { [weak self] rankingTabIsTapped in
                if rankingTabIsTapped {
                    NotificationCenter.default.post(name: NSNotification.Name("ChangeTab"), object: nil, userInfo: ["tab": 1])
                    self?.generator.impactOccurred()
                }
            })
            .disposed(by: disposeBag)
    }
}

extension CustomTabBar: ViewDrawable {
    func configureUI() {
        setBackgroundColor()
        setAutolayout()
    }
    
    func setBackgroundColor() {
        self.backgroundColor = .decisionSkyBlue
    }
    
    func setAutolayout() {
        [detoxTab, settingTab].forEach { self.addSubview($0) }
        
        detoxTab.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(self.deviceSize.adaptedSize(80))
            make.centerY.equalTo(self.snp.centerY)
        }
        
        settingTab.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.trailing).offset(self.deviceSize.adaptedSize(-80))
            make.centerY.equalTo(self.snp.centerY)
        }
    }
}

