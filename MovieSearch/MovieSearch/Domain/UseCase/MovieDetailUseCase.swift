import Foundation

final class MovieDetailUseCase {
    let coreDataRepository: CoreDataRepository
    
    init(
        coreDataRepository: CoreDataRepository = MovieCoreDataRepository()
    ) {
        self.coreDataRepository = coreDataRepository
    }
    
    func saveBookmarkedMovie(_ movie: Movie) {
        coreDataRepository.save(movie)
    }
    
    func deleteBookmarkedMovie(with title: String) {
        coreDataRepository.delete(with: title)
    }
}
