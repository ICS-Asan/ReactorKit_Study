//
//  BoxOfficeViewReactor.swift
//  MovieSearch
//
//  Created by Seul Mac on 2022/08/17.
//

import Foundation
import RxSwift
import ReactorKit

final class BoxOfficeViewReactor: Reactor {
    private let boxOfficeUseCase = BoxOfficeUseCase()
    private let disposeBag: DisposeBag = .init()
    
    enum Action {
        case load
    }
    
    enum Mutation {
        case setBoxOfficeInformation(BoxOfficeInformation?)
        case setLoading(Bool)
    }
    
    struct State {
        var targetDate: String = "20220825"
        var currentBoxOffice: [BoxOfficeMovie] = []
        var isLoading = false
    }
    
    var initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
//        let fetchObservable = boxOfficeUseCase.fetchBoxOfficeChart(with: self.currentState.targetDate)
//            .map{ Mutation.setBoxOfficeInformation($0) }
        switch action {
        case .load:
//            return Observable.concat([
//                Observable.just(.setLoading(true)),
//                fetchObservable,
//                Observable.just(.setLoading(false))
//            ])
            return boxOfficeUseCase.fetchBoxOfficeChart(with: self.currentState.targetDate)
                .map{ Mutation.setBoxOfficeInformation($0) }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setBoxOfficeInformation(let information):
            guard let information = information else { return state }
            newState.targetDate = information.targetDate
            newState.currentBoxOffice = information.boxOfficeMovies.sorted{ $0.rank < $1.rank }
            
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        }
        return newState
    }
    
}

