//
//  DeviceSizeMananger.swift
//  DecisionToLeave
//
//  Created by 황홍필 on 2024/01/24.
//

import UIKit

// 393 x 852 - 시뮬레이터용 iPhone 14 pro 크기


final class DeviceSizeManager {
    static let shared = DeviceSizeManager()
    
    // iPhone 14 Pro 기준 Width, Height
    private let iPhone14ProScreenWidth: CGFloat = 393.0
    private let iPhone14ProScreenHeight: CGFloat = 852.0
    
    // 현재 사용하는 Device의 크기 (iPhone 14, iPad, iPhone 8, iPhone 12 모두 포함)
    private let deviceScreenWidth = UIScreen.main.bounds.size.width
    private let deviceScreenHeight = UIScreen.main.bounds.size.height
    
    // 비율을 계산
    private lazy var widthRatio: CGFloat = deviceScreenWidth / iPhone14ProScreenWidth
    private lazy var heightRatio: CGFloat = deviceScreenHeight / iPhone14ProScreenHeight
    
    // 텍스트의 폰트나 UI의 Width, Height 값을 현재 사용하고 있는 Device에 맞춰서 비율을 조절
    func adaptedSize(_ size: CGFloat) -> CGFloat {
        return size * widthRatio
    }
}
