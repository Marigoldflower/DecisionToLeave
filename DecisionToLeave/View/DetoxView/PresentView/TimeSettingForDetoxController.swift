//
//  DetoxSettingController.swift
//  DecisionToLeave
//
//  Created by 황홍필 on 2024/01/25.
//

import UIKit
import SnapKit
import ReactorKit
import RxCocoa

final class TimeSettingForDetoxController: UIViewController, View {
    
    // MARK: - Vibrate Manager
    private let deviceVibrate = DeviceVibrateManager.shared
    
    // MARK: - Size Manager
    private let deviceSize = DeviceSizeManager.shared

    // 시간 설정 탭을 만들어야 함
    // 1. 30분, 1시간, 2시간, 3시간 단위의 버튼 4개를 만들기
    // 2. 더 큰 단위의 시간은 UIDatePicker로 설정하기
    // 3. 시간 설정하기 버튼 만들기
    
    // MARK: - DisposeBag
    var disposeBag = DisposeBag()
    
    // MARK: - ViewModel
    private let timeSettingForDetoxViewModel = TimeSettingForDetoxViewModel()
    
    // MARK: - UI Components
    private lazy var timeDecideView: TimeDecideView = {
        let view = TimeDecideView()
        view.layer.borderColor = UIColor.decisionBorderGray.cgColor
        view.layer.borderWidth = self.deviceSize.adaptedSize(2.0)
        view.layer.cornerRadius = self.deviceSize.adaptedSize(20)
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var timeTapView: TimeTapView = {
        let view = TimeTapView()
        view.layer.borderColor = UIColor.decisionBorderGray.cgColor
        view.layer.borderWidth = self.deviceSize.adaptedSize(2.0)
        view.layer.cornerRadius = self.deviceSize.adaptedSize(18)
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var timeScrollView: TimeScrollView = {
        let view = TimeScrollView()
        view.layer.borderColor = UIColor.decisionBorderGray.cgColor
        view.layer.borderWidth = self.deviceSize.adaptedSize(2.0)
        view.layer.cornerRadius = self.deviceSize.adaptedSize(18)
        view.layer.masksToBounds = true
        return view
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
        reactor = timeSettingForDetoxViewModel
        configureUI()
    }
}

extension TimeSettingForDetoxController: Bindable {
    func bind(reactor: TimeSettingForDetoxViewModel) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    func bindAction(_ reactor: Reactor) {
        timeTapView.oneHour.rx.tap
            .map { TimeSettingForDetoxViewModel.Action.oneHourPlusTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        timeTapView.thirtyMinutes.rx.tap
            .map { TimeSettingForDetoxViewModel.Action.thirtyMinutesPlusTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        timeTapView.fiveMinutes.rx.tap
            .map { TimeSettingForDetoxViewModel.Action.fiveMinutesPlusTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        timeTapView.resetButton.rx.tap
            .map { TimeSettingForDetoxViewModel.Action.resetButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    func bindState(_ reactor: Reactor) {
        reactor.state
            .map { $0.oneHourPlusIsSelected }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] oneHourPlusIsSelected in
                if oneHourPlusIsSelected {
                    self?.timeDecideView.currentTime += 60 * 60
                    self?.setSelectedButton(of: (self?.timeTapView.oneHour)!)
                }
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.thirtyMinutesPlusIsSelected }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] thirtyMinutesPlusIsSelected in
                if thirtyMinutesPlusIsSelected {
                    self?.timeDecideView.currentTime += 30 * 60
                    self?.setSelectedButton(of: (self?.timeTapView.thirtyMinutes)!)
                }
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.fiveMinutesPlusSelected }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] fiveMinutesPlusSelected in
                if fiveMinutesPlusSelected {
                    self?.timeDecideView.currentTime += 5 * 60
                    self?.setSelectedButton(of: (self?.timeTapView.fiveMinutes)!)
                }
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.resetButtonIsSelected }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] resetButtonIsSelected in
                if resetButtonIsSelected {
                    self?.timeDecideView.currentTime = 0
                    self?.setSelectedButton(of: (self?.timeTapView.resetButton)!)
                }
            })
            .disposed(by: disposeBag)
    }
     
    private func setSelectedButton(of button: UIButton) {
        if button == timeTapView.resetButton {
            setResetAnimatedToSelected(button)
        }
        setAnimationToSelected(button)
        vibrateGenerate()
    }
    
    private func setAnimationToSelected(_ button: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            button.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            button.backgroundColor = UIColor.systemGray3
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                button.transform = CGAffineTransform.identity
                button.backgroundColor = UIColor.decisionBackground
            }
        }
    }
    
    private func setResetAnimatedToSelected(_ button: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            button.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            button.backgroundColor = UIColor.decisionOrange
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                button.transform = CGAffineTransform.identity
                button.backgroundColor = UIColor.decisionPink
            }
        }
    }
}

extension TimeSettingForDetoxController: ViewDrawable {
    func configureUI() {
        insertView()
        setBackgroundColor()
        setAutolayout()
    }
    
    func setBackgroundColor() {
        view.backgroundColor = .decisionBackground
    }
    
    func setAutolayout() {
        [timeDecideView, timeTapView, timeScrollView, createTimeSettingButton].forEach { view.addSubview($0) }
        
        timeDecideView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(self.deviceSize.adaptedSize(20))
            make.trailing.equalTo(view.snp.trailing).offset(self.deviceSize.adaptedSize(-20))
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(self.deviceSize.adaptedSize(30))
            make.height.equalTo(self.deviceSize.adaptedSize(120))
        }
        
        timeTapView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(self.deviceSize.adaptedSize(20))
            make.trailing.equalTo(view.snp.trailing).offset(self.deviceSize.adaptedSize(-20))
            make.top.equalTo(timeDecideView.snp.bottom).offset(self.deviceSize.adaptedSize(30))
            make.height.equalTo(self.deviceSize.adaptedSize(100))
        }
        
        timeScrollView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(self.deviceSize.adaptedSize(20))
            make.trailing.equalTo(view.snp.trailing).offset(self.deviceSize.adaptedSize(-20))
            make.top.equalTo(timeTapView.snp.bottom).offset(self.deviceSize.adaptedSize(30))
            make.bottom.equalTo(createTimeSettingButton.snp.top).offset(self.deviceSize.adaptedSize(-30))
        }
        
        createTimeSettingButton.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(self.deviceSize.adaptedSize(30))
            make.trailing.equalTo(view.snp.trailing).offset(self.deviceSize.adaptedSize(-30))
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(self.deviceSize.adaptedSize(-30))
            make.height.equalTo(self.deviceSize.adaptedSize(60))
        }
    }
    
    private func insertView() {
        setAlarmBorderViewBelowToAlarmImage()
        setFingerTapBorderViewBelowToFingerTapImage()
        setScrollBorderViewBelowToScrollImage()
    }
    
    private func setAlarmBorderViewBelowToAlarmImage() {
        timeDecideView.insertSubview(timeDecideView.alarmBorderView, belowSubview: timeDecideView.alarmImageView)
    }
    
    private func setFingerTapBorderViewBelowToFingerTapImage() {
        timeTapView.insertSubview(timeTapView.fingerTapBorderView, belowSubview: timeTapView.fingerTapImageView)
    }
    
    private func setScrollBorderViewBelowToScrollImage() {
        timeScrollView.insertSubview(timeScrollView.scrollBorderView, belowSubview: timeScrollView.scrollImageView)
    }
}
