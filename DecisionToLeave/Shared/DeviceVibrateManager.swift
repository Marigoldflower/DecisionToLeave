//
//  DeviceVibrateManager.swift
//  DecisionToLeave
//
//  Created by 황홍필 on 2024/01/25.
//

import UIKit

final class DeviceVibrateManager {
    static let shared = DeviceVibrateManager()
    
    let generator = UIImpactFeedbackGenerator(style: .soft)
}
