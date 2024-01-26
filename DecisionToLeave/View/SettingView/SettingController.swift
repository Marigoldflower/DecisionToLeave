//
//  RankingController.swift
//  DecisionToLeave
//
//  Created by 황홍필 on 2024/01/19.
//

import UIKit
import SnapKit

final class SettingController: UIViewController {
    
    // MARK: - Size Manager
    let deviceSize = DeviceSizeManager.shared
    
    // MARK: - UI Components
    private lazy var customTabBar: CustomTabBar = {
        let view = CustomTabBar()
        view.layer.borderColor = UIColor.decisionBorderGray.cgColor
        view.layer.borderWidth = self.deviceSize.adaptedSize(2.0)
        view.layer.cornerRadius = self.deviceSize.adaptedSize(30)
        view.layer.masksToBounds = true
        return view
    }()
    
    private var selectedTab: UIView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

extension SettingController: ViewDrawable {
    func configureUI() {
        setBackgroundColor()
        setAutolayout()
        setSelectedCircleBelowToRankingTab()
    }
    
    func setBackgroundColor() {
        self.view.backgroundColor = .decisionBackground
    }
    
    func setAutolayout() {
        [customTabBar].forEach { view.addSubview($0) }
        [customTabBar.selectedCircle].forEach { customTabBar.addSubview($0) }
        
        customTabBar.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(self.deviceSize.adaptedSize(30))
            make.trailing.equalTo(view.snp.trailing).offset(self.deviceSize.adaptedSize(-30))
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(self.deviceSize.adaptedSize(-30))
            make.height.equalTo(self.deviceSize.adaptedSize(60))
        }
        
        customTabBar.selectedCircle.snp.makeConstraints { make in
            make.center.equalTo(customTabBar.settingTab.snp.center)
            make.width.height.equalTo(self.deviceSize.adaptedSize(44))
        }
    }
    
    private func setSelectedCircleBelowToRankingTab() {
        customTabBar.insertSubview(customTabBar.selectedCircle, belowSubview: customTabBar.settingTab)
    }
}
