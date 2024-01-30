//
//  DetoxViewModel.swift
//  DecisionToLeave
//
//  Created by 황홍필 on 2024/01/30.
//

import ReactorKit

final class DetoxViewModel: Reactor {
    
    enum Action {
        case detoxTabTapped
        case rankingTabTapped
    }
    
    enum Mutation {
        case presentDetoxController(Bool)
        case presentRankingController(Bool)
    }

    struct State {
        var detoxControllerPresented: Bool = false
        var rankingControllerPresented: Bool = false
    }
    
    var initialState: State
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .detoxTabTapped:
            return Observable.concat([
                Observable.just(Mutation.presentDetoxController(true)),
                Observable.just(Mutation.presentDetoxController(false))
            ])
        case .rankingTabTapped:
            return Observable.concat([
                Observable.just(Mutation.presentRankingController(true)),
                Observable.just(Mutation.presentRankingController(false))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .presentDetoxController(let value):
            newState.detoxControllerPresented = value
        case .presentRankingController(let value):
            newState.rankingControllerPresented = value
        }
        
        return newState
    }
}

