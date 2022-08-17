import Foundation
import RxSwift

final class BookmarkListUseCase {
    let coreDataRepository: CoreDataRepository
    
    init(
        coreDataRepository: CoreDataRepository = MovieCoreDataRepository()
    ) {
        self.coreDataRepository = coreDataRepository
    }

    func fetchBookmarkedMovie() -> Observable<[Movie]> {
        return coreDataRepository.fetch()
    }
    
    func saveBookmarkedMovie(_ movie: Movie) {
        coreDataRepository.save(movie)
    }
    
    func deleteBookmarkedMovie(with title: String) {
        coreDataRepository.delete(with: title)
    }
}

