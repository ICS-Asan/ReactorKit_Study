import Foundation
import RxSwift

final class MovieDetailViewModel {
    private let movieDetailUseCase = MovieDetailUseCase()
    private let disposeBag: DisposeBag = .init()
    private(set) var currentMovie: Movie?
    
    func transform(_ input: Input) -> Output {
        input
            .setupViewObserver
            .subscribe(onNext: { [weak self] movie in
                self?.receiveCurrentMovie(movie)
            })
            .disposed(by: disposeBag)
        
        let updatedBookmarkState = input.didTabBookmarkButton
            .withUnretained(self)
            .map { (owner, _) -> Bool? in
                owner.toggleBookmarkState()
                return owner.currentMovie?.isBookmarked
            }
        
        return Output(updateBookmarkStateObservable: updatedBookmarkState)
    }
    
    private func receiveCurrentMovie(_ movie: Movie) {
        currentMovie = movie
    }
    
    private func toggleBookmarkState() {
        currentMovie?.isBookmarked.toggle()
        guard let currentMovie = currentMovie else { return }
        if currentMovie.isBookmarked == true {
            movieDetailUseCase.saveBookmarkedMovie(currentMovie)
        } else {
            movieDetailUseCase.deleteBookmarkedMovie(with: currentMovie.title)
        }
    }
}

extension MovieDetailViewModel {
    final class Input {
        let setupViewObserver: Observable<Movie>
        let didTabBookmarkButton: Observable<Void>
        init(
            setupViewObserver: Observable<Movie>,
            didTabBookmarkButton: Observable<Void>
        ) {
            self.setupViewObserver = setupViewObserver
            self.didTabBookmarkButton = didTabBookmarkButton
        }
    }

    final class Output {
        let updateBookmarkStateObservable: Observable<Bool?>
        init(updateBookmarkStateObservable: Observable<Bool?>) {
            self.updateBookmarkStateObservable = updateBookmarkStateObservable
        }
    }

}
