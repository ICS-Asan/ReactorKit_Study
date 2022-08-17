import Foundation
import RxSwift

protocol ChartNetworkRepository {
    func fetchBoxOfficeInformation(with targetDate: String) -> Observable<BoxOfficeInformation?>
}
