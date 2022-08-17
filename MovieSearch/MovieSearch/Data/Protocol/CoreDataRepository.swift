import Foundation
import RxSwift

protocol CoreDataRepository {
    func fetch() -> Observable<[Movie]>
    func save(_ movie: Movie)
    func delete(with title: String)
}
