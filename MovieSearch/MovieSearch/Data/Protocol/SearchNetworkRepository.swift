import Foundation
import RxSwift

protocol SearchNetworkRepository {
    func fetchMovieSearchInformation(with searchWord: String) -> Observable<MovieSearchInformation?>
}
