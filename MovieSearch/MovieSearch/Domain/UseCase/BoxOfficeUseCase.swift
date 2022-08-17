//
//  BoxOfficeUseCase.swift
//  MovieSearch
//
//  Created by Seul Mac on 2022/08/17.
//

import Foundation
import RxSwift

final class BoxOfficeUseCase {
    let boxOfficeNetworkRepository: ChartNetworkRepository
    
    
    init(
        boxOfficeNetworkRepository: ChartNetworkRepository = KOFICBoxOfficeNetworkRepository()
    ) {
        self.boxOfficeNetworkRepository = boxOfficeNetworkRepository
    }
    
    func fetchBoxOfficeChart(with date: String) -> Observable<BoxOfficeInformation?> {
        return boxOfficeNetworkRepository.fetchBoxOfficeInformation(with: date)
    }
}
