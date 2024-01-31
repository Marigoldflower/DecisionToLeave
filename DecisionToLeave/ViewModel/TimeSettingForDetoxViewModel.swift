//
//  CustomTabBarViewModel.swift
//  DecisionToLeave
//
//  Created by 황홍필 on 2024/01/24.
//

import ReactorKit

final class TimeSettingForDetoxViewModel: Reactor {
    
    enum Action {
        case thirtyMinutesTapped
        case oneHourTapped
        case twoHourTapped
        case threeHourTapped
    }
    
    enum Mutation {
        case settingThirtyMinutes(Bool)
        case settingOneHour(Bool)
        case settingTwoHour(Bool)
        case settingThreeHour(Bool)
    }

    struct State {
        var thirtyMinutesIsSelected: Bool = false
        var oneHourIsSelected: Bool = false
        var twoHourIsSelected: Bool = false
        var threeHourIsSelected: Bool = false
    }
    
    var initialState: State
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .thirtyMinutesTapped:
            return Observable.concat([
                Observable.just(Mutation.settingThirtyMinutes(true)),
                Observable.just(Mutation.settingThirtyMinutes(false))
            ])
            
        case .oneHourTapped:
            return Observable.concat([
                Observable.just(Mutation.settingOneHour(true)),
                Observable.just(Mutation.settingOneHour(false))
            ])
            
        case .twoHourTapped:
            return Observable.concat([
                Observable.just(Mutation.settingTwoHour(true)),
                Observable.just(Mutation.settingTwoHour(false))
            ])
            
        case .threeHourTapped:
            return Observable.concat([
                Observable.just(Mutation.settingThreeHour(true)),
                Observable.just(Mutation.settingThreeHour(false))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .settingThirtyMinutes(let value):
            newState.thirtyMinutesIsSelected = value
        case .settingOneHour(let value):
            newState.oneHourIsSelected = value
        case .settingTwoHour(let value):
            newState.twoHourIsSelected = value
        case .settingThreeHour(let value):
            newState.threeHourIsSelected = value
        }
        
        return newState
    }
}
