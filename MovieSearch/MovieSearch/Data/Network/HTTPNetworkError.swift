import Foundation

enum HTTPNetworkError: String, LocalizedError {
    case invalidEndPoint = "ERROR: Invalid EndPoint"
    case invalidRequest = "ERROR: Invalid Request"
    
    var errorDescription: String {
        return self.rawValue
    }
}
