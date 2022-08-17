import Foundation
import RxSwift

final class KOFICBoxOfficeNetworkRepository: ChartNetworkRepository {
    func fetchBoxOfficeInformation(with targetDate: String) -> Observable<BoxOfficeInformation?> {
        let boxOfficeInformation = HTTPNetworkManager.shared.fetch(
            with: EndPoint.movieChart(date: targetDate).url
        )
            .map { data -> BoxOfficeInformation? in
                let decodedData = JSONParser.decodeData(of: data, type: BoxOfficeResultDTO.self)
                
                return decodedData?.toDomain()
            }
        
        return boxOfficeInformation
    }
}
