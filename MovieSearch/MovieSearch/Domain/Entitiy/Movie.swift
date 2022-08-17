import Foundation

struct Movie: Hashable {
    let title: String
    let link: String
    let image: String
    let subtitle: String
    let pubDate: String
    let director: String
    let actor: String
    let userRating: String
    var isBookmarked: Bool = false
}
