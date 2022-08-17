import Foundation
import RxSwift

final class MovieCoreDataRepository: CoreDataRepository {
    func fetch() -> Observable<[Movie]> {
        return CoreDataManager.shared.fetch()
            .map { movieCoreDatas in
                movieCoreDatas.map { $0.toDomain() }
            }
    }
    
    func save(_ movie: Movie) {
        CoreDataManager.shared.save(movie)
    }
    
    func delete(with title: String) {
        CoreDataManager.shared.delete(with: title)
    }
}
