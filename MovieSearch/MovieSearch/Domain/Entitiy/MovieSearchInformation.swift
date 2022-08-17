import Foundation

struct MovieSearchInformation: Hashable {
    let lastBuildDate: String
    let total: Int
    let start: Int
    let display: Int
    let items: [Movie]
}
