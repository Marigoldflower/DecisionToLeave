//
//  MainTabBarController.swift
//  DecisionToLeave
//
//  Created by 황홍필 on 2024/01/24.
//

import UIKit

final class MainTabBarController: UITabBarController {
    // MARK: - UI Components
    private let detox = UINavigationController(rootViewController: DetoxController())
    private let ranking = UINavigationController(rootViewController: SettingController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarUI()
    }
    
    private func setTabBarUI() {
        setTabBarElements()
        setTabBarImage()
        setTabBarHidden()
        changeTabWithNotification()
    }
    
    private func setTabBarElements() {
        viewControllers = [detox, ranking]
    }
    
    private func setTabBarImage() {
        guard let items = tabBar.items else { return }
        
        items[0].image = UIImage(systemName: "hand.raised.slash.fill")
        items[1].image = UIImage(systemName: "trophy.fill")
    }
    
    private func setTabBarHidden() {
        tabBar.isHidden = true
    }
    
    private func changeTabWithNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(changeTab(_:)), name: NSNotification.Name("ChangeTab"), object: nil)
    }
    
    // MARK: - objc
    @objc func changeTab(_ notification: Notification) {
        if let tab = notification.userInfo?["tab"] as? Int {
            selectedIndex = tab
        }
    }
}
