import Foundation

enum CoreDataError: String, LocalizedError {
    case FetchFail = "ERROR: CoreData Fetch Fail"
    case SaveFail = "ERROR: CoreData Save Fail"
    
    var errorDescription: String {
        return self.rawValue
    }
}
