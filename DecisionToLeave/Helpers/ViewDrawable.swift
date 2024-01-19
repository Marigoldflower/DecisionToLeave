//
//  ViewDrawable.swift
//  DecisionToLeave
//
//  Created by 황홍필 on 2024/01/19.
//

import Foundation

protocol ViewDrawable: AnyObject {
    func configureUI()
    func setBackgroundColor()
    func setAutolayout()
}
