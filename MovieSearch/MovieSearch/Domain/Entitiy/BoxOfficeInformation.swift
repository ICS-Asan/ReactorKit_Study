import Foundation

struct BoxOfficeInformation: Hashable {
    let boxOfficeType: String
    let targetDate: String
    let boxOfficeMovies: [BoxOfficeMovie]
}
