//
//  ViewController.swift
//  DecisionToLeave
//
//  Created by 황홍필 on 2024/01/19.
//

import UIKit
import SnapKit

final class DetoxController: UIViewController {
    
    // MARK: - Vibrate Manager
    private let deviceVibrate = DeviceVibrateManager.shared
    
    // MARK: - Size Manager
    private let deviceSize = DeviceSizeManager.shared
    
    // MARK: - Tap Gestures
    lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(createDetoxViewTapped))
    
    // MARK: - PresentView
    private var detoxSettingController: DetoxSettingController! = nil
    
    // MARK: - UI Components
    private lazy var lockThePhone: UILabel = {
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
    
    private lazy var detoxTimeRemainView: DetoxTimeRemainView = {
        let view = DetoxTimeRemainView()
        view.layer.borderColor = UIColor.decisionBorderGray.cgColor
        view.layer.borderWidth = self.deviceSize.adaptedSize(2.0)
        view.layer.cornerRadius = self.deviceSize.adaptedSize(28)
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
    
    // MARK: - @objc
    @objc func createDetoxViewTapped() {
        vibrateGenerate()
        presentToDetoxSettingController()
    }
    
    private func vibrateGenerate() {
        self.deviceVibrate.generator.impactOccurred()
    }
    
    private func presentToDetoxSettingController() {
        detoxSettingController = DetoxSettingController()
        setNavigationTitleAndButton(at: detoxSettingController)
        setNavigationController(appearance: customNavigationBar())
    }
    
    private func customNavigationBar() -> UINavigationBarAppearance {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .decisionRetroBackground // UINavigationBar의 bar 색상 설정
        navigationBarAppearance.titleTextAttributes = [
            .font: UIFont.LINESeedRegular(size: deviceSize.adaptedSize(18)) as Any, // 텍스트 폰트 설정
            .foregroundColor: UIColor.decisionBlack // 텍스트 색상 설정
        ]
        return navigationBarAppearance
    }
    
    private func setNavigationController(appearance: UINavigationBarAppearance) {
        let navigation = UINavigationController(rootViewController: detoxSettingController)
        navigation.modalPresentationStyle = .fullScreen
        navigation.navigationBar.standardAppearance = appearance
        navigation.navigationBar.scrollEdgeAppearance = appearance
        setNavigationBarBorder(navigation: navigation)
        present(navigation, animated: true)
    }
    
    private func setNavigationBarBorder(navigation: UINavigationController) {
        let navBorder = UIView()
        navBorder.backgroundColor = .decisionBorderGray    // border 색상 설정
        navBorder.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.size.height ?? 0) - 2, width: (self.navigationController?.navigationBar.frame.size.width ?? 0), height: deviceSize.adaptedSize(2.0))    // border 크기 및 위치 설정
        
        navigation.navigationBar.addSubview(navBorder)
    }
    
    private func setNavigationTitleAndButton(at view: DetoxSettingController) {
        setNavigationBarTitle(at: view)
        setNavigationCloseButton(at: view)
    }
    
    private func setNavigationBarTitle(at view: DetoxSettingController) {
        view.navigationItem.title = "휴대폰 잠그기"
    }
    
    private func setNavigationCloseButton(at view: DetoxSettingController) {
        let customButton: UIButton = {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: Int(self.deviceSize.adaptedSize(45)), height: Int(self.deviceSize.adaptedSize(13))))
            button.setTitle("닫기", for: .normal)
            button.titleLabel?.font = .LINESeedRegular(size: self.deviceSize.adaptedSize(13))
            button.setTitleColor(.decisionBlack, for: .normal)
            button.layer.borderColor = UIColor.decisionBorderGray.cgColor
            button.layer.borderWidth = self.deviceSize.adaptedSize(2.0)
            button.layer.cornerRadius = self.deviceSize.adaptedSize(13)
            button.layer.masksToBounds = true
            button.backgroundColor = .decisionPink
            button.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
            return button
        }()
        
        let closeButton = UIBarButtonItem(customView: customButton)
        view.navigationItem.rightBarButtonItem = closeButton
    }
    
    @objc func rightButtonAction() {
        deviceVibrate.generator.impactOccurred()
        self.dismiss(animated: true)
    }
}

extension DetoxController: ViewDrawable {
    func configureUI() {
        setBackgroundColor()
        setAutolayout()
        setSelectedCircleBelowToDetoxTab()
        setTapGestures()
    }
    
    func setBackgroundColor() {
        self.view.backgroundColor = .decisionBackground
    }
    
    func setAutolayout() {
        [customTabBar, lockThePhone, createDetoxView, detoxTimeRemainView].forEach { view.addSubview($0) }
        [customTabBar.selectedCircle].forEach { customTabBar.addSubview($0) }
        
        lockThePhone.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(self.deviceSize.adaptedSize(30))
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(self.deviceSize.adaptedSize(30))
        }
        
        createDetoxView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(self.deviceSize.adaptedSize(20))
            make.trailing.equalTo(view.snp.trailing).offset(self.deviceSize.adaptedSize(-20))
            make.top.equalTo(lockThePhone.snp.bottom).offset(self.deviceSize.adaptedSize(30))
            make.height.equalTo(self.deviceSize.adaptedSize(120))
        }
        
        detoxTimeRemainView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(self.deviceSize.adaptedSize(20))
            make.trailing.equalTo(view.snp.trailing).offset(self.deviceSize.adaptedSize(-20))
            make.top.equalTo(createDetoxView.snp.bottom).offset(self.deviceSize.adaptedSize(30))
            make.bottom.equalTo(customTabBar.snp.top).offset(self.deviceSize.adaptedSize(-30))
        }
        
        customTabBar.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(self.deviceSize.adaptedSize(30))
            make.trailing.equalTo(view.snp.trailing).offset(self.deviceSize.adaptedSize(-30))
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(self.deviceSize.adaptedSize(-30))
            make.height.equalTo(self.deviceSize.adaptedSize(60))
        }
        
        customTabBar.selectedCircle.snp.makeConstraints { make in
            make.center.equalTo(customTabBar.detoxTab.snp.center)
            make.width.height.equalTo(self.deviceSize.adaptedSize(44))
        }
    }
    
    private func setSelectedCircleBelowToDetoxTab() {
        customTabBar.insertSubview(customTabBar.selectedCircle, belowSubview: customTabBar.detoxTab)
    }
    
    // Tap Gestures 설정
    private func setTapGestures() {
        createDetoxView.addGestureRecognizer(tapGesture)
    }
}
