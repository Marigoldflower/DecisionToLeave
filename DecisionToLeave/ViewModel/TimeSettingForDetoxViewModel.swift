//
//  CustomTabBarViewModel.swift
//  DecisionToLeave
//
//  Created by 황홍필 on 2024/01/24.
//

import ReactorKit

final class TimeSettingForDetoxViewModel: Reactor {
    
    enum Action {
        case oneHourPlusTapped
        case thirtyMinutesPlusTapped
        case fiveMinutesPlusTapped
        case resetButtonTapped
    }
    
    enum Mutation {
        case settingOneHourPlus(Bool)
        case settingThirtyMinutesPlus(Bool)
        case settingFiveMinutesPlus(Bool)
        case settingReset(Bool)
    }

    struct State {
        var oneHourPlusIsSelected: Bool = false
        var thirtyMinutesPlusIsSelected: Bool = false
        var fiveMinutesPlusSelected: Bool = false
        var resetButtonIsSelected: Bool = false
    }
    
    var initialState: State
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .oneHourPlusTapped:
            return Observable.concat([
                Observable.just(Mutation.settingOneHourPlus(true)),
                Observable.just(Mutation.settingOneHourPlus(false))
            ])
            
        case .thirtyMinutesPlusTapped:
            return Observable.concat([
                Observable.just(Mutation.settingThirtyMinutesPlus(true)),
                Observable.just(Mutation.settingThirtyMinutesPlus(false))
            ])
            
        case .fiveMinutesPlusTapped:
            return Observable.concat([
                Observable.just(Mutation.settingFiveMinutesPlus(true)),
                Observable.just(Mutation.settingFiveMinutesPlus(false))
            ])
            
        case .resetButtonTapped:
            return Observable.concat([
                Observable.just(Mutation.settingReset(true)),
                Observable.just(Mutation.settingReset(false))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .settingOneHourPlus(let value):
            newState.oneHourPlusIsSelected = value
        case .settingThirtyMinutesPlus(let value):
            newState.thirtyMinutesPlusIsSelected = value
        case .settingFiveMinutesPlus(let value):
            newState.fiveMinutesPlusSelected = value
        case .settingReset(let value):
            newState.resetButtonIsSelected = value
        }
        
        return newState
    }
}
