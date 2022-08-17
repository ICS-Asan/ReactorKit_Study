import Foundation
import RxSwift

final class NaverMovieNetworkRepository: SearchNetworkRepository {
    func fetchMovieSearchInformation(with searchWord: String) -> Observable<MovieSearchInformation?> {
        let movieSearchInformation = HTTPNetworkManager.shared.fetch(
            with: EndPoint.movieSearch(word: searchWord).url,
            hearder: ClientInformation.Search.headerValue
        )
            .map { data -> MovieSearchInformation? in
                let decodedData = JSONParser.decodeData(of: data, type: MovieSearhInformationDTO.self)
                
                return decodedData?.toDomain()
            }
        
        return movieSearchInformation
        
    }
}
