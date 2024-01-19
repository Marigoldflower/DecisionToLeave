//
//  CustomTabBar.swift
//  DecisionToLeave
//
//  Created by 황홍필 on 2024/01/19.
//

import UIKit
import SnapKit

final class CustomTabBar: UIView {
    
    // MARK: - UI Components
    

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}

extension CustomTabBar: ViewDrawable {
    func configureUI() {
        setBackgroundColor()
        setAutolayout()
    }
    
    func setBackgroundColor() {
        
    }
    
    func setAutolayout() {
        
    }
}

