import Foundation
import RxSwift

final class MovieSearchUseCase {
    let movieNetworkRepository: SearchNetworkRepository
    let coreDataRepository: CoreDataRepository
    
    init(
        movieNetworkRepository: SearchNetworkRepository = NaverMovieNetworkRepository(),
        coreDataRepository: CoreDataRepository = MovieCoreDataRepository()
    ) {
        self.movieNetworkRepository = movieNetworkRepository
        self.coreDataRepository = coreDataRepository
    }
    
    func fetchMovieSearchInformation(with searchWord: String) -> Observable<MovieSearchInformation?> {
        return movieNetworkRepository.fetchMovieSearchInformation(with: searchWord)
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
