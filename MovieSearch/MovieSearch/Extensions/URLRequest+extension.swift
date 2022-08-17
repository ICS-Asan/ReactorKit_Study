import Foundation

extension URLRequest {
    enum HttpMethod {
        case get
    }
    
    init(url: URL, method: HttpMethod) {
        self.init(url: url)

        switch method {
        case .get:
            self.httpMethod = "GET"
        }
    }
}
