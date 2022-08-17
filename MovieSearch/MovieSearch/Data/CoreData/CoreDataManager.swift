import Foundation
import CoreData
import RxSwift

final class CoreDataManager {
    static let shared = CoreDataManager()
    private let persistentContainer = NSPersistentCloudKitContainer(name: MovieCoreDataDTO.entityName)
    private(set) lazy var context = persistentContainer.viewContext
    
    private init() {
        loadPersistentContainer()
    }
    
    private func loadPersistentContainer() {
        persistentContainer.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    func fetch() -> Observable<[MovieCoreDataDTO]> {
        return Observable.create { [weak self] emitter in
            guard let movies = try? self?.context.fetch(MovieCoreDataDTO.fetchRequest()) else {
                emitter.onError(CoreDataError.FetchFail)
                return Disposables.create()
            }
            
            emitter.onNext(movies)
            emitter.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func save(_ movie: Movie) {
        let movieObject = MovieCoreDataDTO(context: context)
        movieObject.title = movie.title
        movieObject.link = movie.link
        movieObject.image = movie.image
        movieObject.subtitle = movie.subtitle
        movieObject.pubDate = movie.pubDate
        movieObject.director = movie.director
        movieObject.actor = movie.actor
        movieObject.userRating = movie.userRating
        movieObject.isBookmarked = movie.isBookmarked
        
        saveContextChange()
    }
    
    func delete(with title: String) {
        let request = MovieCoreDataDTO.fetchRequest()
        let predicate = NSPredicate(format: "title == %@", title)
        request.predicate = predicate
        
        guard let fetchResult = try? context.fetch(request) else { return }
        fetchResult.forEach {
            context.delete($0)
        }
        
        saveContextChange()
    }
    
    private func saveContextChange() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(CoreDataError.FetchFail.errorDescription)
            }
        }
    }
}
