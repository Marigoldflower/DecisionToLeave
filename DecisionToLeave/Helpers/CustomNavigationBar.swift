//
//  CustomNavigationBar.swift
//  DecisionToLeave
//
//  Created by 황홍필 on 2024/01/25.
//

import UIKit

final class CustomNavigationBar: UINavigationBar {
    
    // MARK: - Size Manager
    private let deviceSize = DeviceSizeManager.shared
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: deviceSize.adaptedSize(85))
    }
   
}
