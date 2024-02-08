//
//  SaveOrNotController.swift
//  DecisionToLeave
//
//  Created by 황홍필 on 2024/02/05.
//

import UIKit
import SnapKit

final class SaveOrNotController: UIViewController {
    
    // MARK: - Size Manager
    private let deviceSize = DeviceSizeManager.shared

    // MARK: - UI Components
    private lazy var saveOrNotAlertView: SaveOrNotAlertView = {
        let view = SaveOrNotAlertView()
        view.layer.borderColor = UIColor.decisionBorderGray.cgColor
        view.layer.borderWidth = self.deviceSize.adaptedSize(2.0)
        view.layer.cornerRadius = self.deviceSize.adaptedSize(20)
        view.layer.masksToBounds = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

extension SaveOrNotController: ViewDrawable {
    func configureUI() {
        setBackgroundColor()
        setAutolayout()
    }
    
    func setBackgroundColor() {
        view.backgroundColor = .black.withAlphaComponent(0.4)
    }
    
    func setAutolayout() {
        [saveOrNotAlertView].forEach { view.addSubview($0) }
        
        saveOrNotAlertView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
    }
}
