import Foundation

struct MovieSearhInformationDTO: Codable {
    let lastBuildDate: String
    let total: Int
    let start: Int
    let display: Int
    let items: [MovieDTO]
    
    func toDomain() -> MovieSearchInformation {
        let movies = items.map { $0.toDomain() }
        
        return MovieSearchInformation(
            lastBuildDate: lastBuildDate,
            total: total,
            start: start,
            display: display,
            items: movies
            )
    }
}
