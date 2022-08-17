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
    enum Action {
        case load
    }
    
    enum Mutation {
        case addBoxOfficeMovies
        case setLoading
    }
    
    struct State {
        var currentBoxOffice: [BoxOfficeMovie] = []
        var isLoading = false
    }
    
    let initialState = State()
    
}
