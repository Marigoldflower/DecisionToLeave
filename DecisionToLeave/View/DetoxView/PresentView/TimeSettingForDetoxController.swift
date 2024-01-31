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
        timeTapView.thirtyMinutes.rx.tap
            .map { TimeSettingForDetoxViewModel.Action.thirtyMinutesTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        timeTapView.oneHour.rx.tap
            .map { TimeSettingForDetoxViewModel.Action.oneHourTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        timeTapView.twoHour.rx.tap
            .map { TimeSettingForDetoxViewModel.Action.twoHourTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        timeTapView.threeHour.rx.tap
            .map { TimeSettingForDetoxViewModel.Action.threeHourTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    func bindState(_ reactor: Reactor) {
        reactor.state
            .map { $0.thirtyMinutesIsSelected }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] thirtyMinutesButtonIsSelected in
                if thirtyMinutesButtonIsSelected {
                    print("30분 추가!")
                    self?.setUnselectedButton()
                    self?.setSelectedButton(of: (self?.timeTapView.thirtyMinutes)!)
                }
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.oneHourIsSelected }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] oneHourButtonIsSelected in
                if oneHourButtonIsSelected {
                    print("1시간 추가!")
                    self?.setUnselectedButton()
                    self?.setSelectedButton(of: (self?.timeTapView.oneHour)!)
                }
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.twoHourIsSelected }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] twoHourButtonIsSelected in
                if twoHourButtonIsSelected {
                    print("2시간 추가!")
                    self?.setUnselectedButton()
                    self?.setSelectedButton(of: (self?.timeTapView.twoHour)!)
                }
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.threeHourIsSelected }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] threeHourButtonIsSelected in
                if threeHourButtonIsSelected {
                    print("3시간 추가!")
                    self?.setUnselectedButton()
                    self?.setSelectedButton(of: (self?.timeTapView.threeHour)!)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setUnselectedButton() {
        self.timeTapView.buttons.forEach {
            $0.backgroundColor = .decisionBackground
        }
    }
    
    private func setSelectedButton(of button: UIButton) {
        button.backgroundColor = .decisionOrange
        button.setTitleColor(.decisionBlack, for: .normal)
        setAnimationToSelected(button)
        vibrateGenerate()
    }
    
    private func setAnimationToSelected(_ button: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            button.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            button.backgroundColor = UIColor.decisionBackground
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                button.transform = CGAffineTransform.identity
                button.backgroundColor = UIColor.decisionOrange
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
        [timeDecideView, timeTapView, createTimeSettingButton].forEach { view.addSubview($0) }
        
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
    }
    
    private func setAlarmBorderViewBelowToAlarmImage() {
        timeDecideView.insertSubview(timeDecideView.alarmBorderView, belowSubview: timeDecideView.alarmImageView)
    }
    
    private func setFingerTapBorderViewBelowToFingerTapImage() {
        timeTapView.insertSubview(timeTapView.fingerTapBorderView, belowSubview: timeTapView.fingerTapImageView)
    }
}
