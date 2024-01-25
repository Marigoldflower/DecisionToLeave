//
//  ViewController.swift
//  DecisionToLeave
//
//  Created by 황홍필 on 2024/01/19.
//

import UIKit
import SnapKit

final class DetoxController: UIViewController {
    
    // MARK: - Size Manager
    let deviceSize = DeviceSizeManager.shared
    
    // MARK: - UI Components
    private lazy var stopThePhone: UILabel = {
        let label = UILabel()
        label.font = .LINESeedBold(size: self.deviceSize.adaptedSize(30))
        label.text = "휴대폰 잠그기"
        label.textColor = .decisionBlack
        return label
    }()
    
    private lazy var createDetoxView: CreateDetoxView = {
        let view = CreateDetoxView()
        view.layer.borderColor = UIColor.decisionBorderGray.cgColor
        view.layer.borderWidth = self.deviceSize.adaptedSize(2.0)
        view.layer.cornerRadius = self.deviceSize.adaptedSize(20)
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var customTabBar: CustomTabBar = {
        let view = CustomTabBar()
        view.layer.borderColor = UIColor.decisionBorderGray.cgColor
        view.layer.borderWidth = self.deviceSize.adaptedSize(2.0)
        view.layer.cornerRadius = self.deviceSize.adaptedSize(30)
        view.layer.masksToBounds = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("DetoxController 화면이 보임")
    }
}

extension DetoxController: ViewDrawable {
    func configureUI() {
        setBackgroundColor()
        setAutolayout()
        setSelectedCircleBelowToDetoxTab()
    }
    
    func setBackgroundColor() {
        self.view.backgroundColor = .decisionBackground
    }
    
    func setAutolayout() {
        [customTabBar, stopThePhone, createDetoxView].forEach { view.addSubview($0) }
        [customTabBar.selectedCircle].forEach { customTabBar.addSubview($0) }
        
        customTabBar.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(self.deviceSize.adaptedSize(30))
            make.trailing.equalTo(view.snp.trailing).offset(self.deviceSize.adaptedSize(-30))
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(self.deviceSize.adaptedSize(-30))
            make.height.equalTo(self.deviceSize.adaptedSize(60))
        }
        
        stopThePhone.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(self.deviceSize.adaptedSize(30))
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(self.deviceSize.adaptedSize(30))
        }
        
        createDetoxView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(self.deviceSize.adaptedSize(20))
            make.trailing.equalTo(view.snp.trailing).offset(self.deviceSize.adaptedSize(-20))
            make.top.equalTo(stopThePhone.snp.bottom).offset(self.deviceSize.adaptedSize(30))
            make.height.equalTo(self.deviceSize.adaptedSize(120))
        }
        
        customTabBar.selectedCircle.snp.makeConstraints { make in
            make.center.equalTo(customTabBar.detoxTab.snp.center)
            make.width.height.equalTo(self.deviceSize.adaptedSize(44))
        }
    }
    
    private func setSelectedCircleBelowToDetoxTab() {
        customTabBar.insertSubview(customTabBar.selectedCircle, belowSubview: customTabBar.detoxTab)
    }
}
