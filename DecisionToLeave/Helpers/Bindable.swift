//
//  Bindable.swift
//  DecisionToLeave
//
//  Created by 황홍필 on 2024/01/19.
//

import ReactorKit

protocol Bindable {
    associatedtype Reactor: ReactorKit.Reactor
    func bindState(_ reactor: Reactor)
    func bindAction(_ reactor: Reactor)
}
