import Foundation
import RxSwift

final class BookmarkListViewModel {
    private let bookmarkListUseCase = BookmarkListUseCase()
    private let disposeBag: DisposeBag = .init()
    private(set) var bookmarkedMovie: [Movie] = []
    
    func transform(_ input: Input) -> Output {
        let bookmarkedMovies = input.viewWillAppearObservable
            .withUnretained(self)
            .flatMap { (owner, _) in
                owner.fetchBookmarkedMovie()
            }
            .map { result -> [Movie] in
                self.storeBookmarkedMovie(movies: result)
                return self.bookmarkedMovie
            }
        
        let updatedBookmarkedMovies = input.didTabBookmarkButton
            .withUnretained(self)
            .flatMap { (owner, title) -> Observable<[Movie]> in
                owner.toggleBookmarkState(of: title)
                return owner.fetchBookmarkedMovie()
            }
            .map { bookmarkedMovies -> [Movie] in
                self.storeBookmarkedMovie(movies: bookmarkedMovies)
                return self.bookmarkedMovie
            }
        
        return Output(
            loadBookmarkedMovies: bookmarkedMovies,
            updateBookmrakedMovies: updatedBookmarkedMovies
        )
    }
    
    func fetchBookmarkedMovie() -> Observable<[Movie]> {
        return bookmarkListUseCase.fetchBookmarkedMovie()
    }
    
    private func storeBookmarkedMovie(movies: [Movie]) {
        bookmarkedMovie = movies
    }
    
    private func toggleBookmarkState(of title: String) {
        guard let index = bookmarkedMovie.firstIndex(where: { $0.title  == title }) else { return }
        let currentBookmarkState = bookmarkedMovie[index].isBookmarked
        if currentBookmarkState == true {
            bookmarkedMovie[index].isBookmarked = false
            bookmarkListUseCase.deleteBookmarkedMovie(with: self.bookmarkedMovie[index].title)
        } else {
            bookmarkedMovie[index].isBookmarked = true
            bookmarkListUseCase.saveBookmarkedMovie(self.bookmarkedMovie[index])
        }
    }
}

extension BookmarkListViewModel {
    final class Input {
        let viewWillAppearObservable: Observable<Void>
        let didTabBookmarkButton: Observable<String>

        init(
            viewWillAppearObservable: Observable<Void>,
            didTabBookmarkButton: Observable<String>
        ) {
            self.viewWillAppearObservable = viewWillAppearObservable
            self.didTabBookmarkButton = didTabBookmarkButton
        }
    }

    final class Output {
        let loadBookmarkedMovies: Observable<[Movie]>
        let updateBookmrakedMovies: Observable<[Movie]>
        
        init(
            loadBookmarkedMovies: Observable<[Movie]>,
            updateBookmrakedMovies: Observable<[Movie]>
        ) {
            self.loadBookmarkedMovies = loadBookmarkedMovies
            self.updateBookmrakedMovies = updateBookmrakedMovies
        }
    }
}
