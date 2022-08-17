import Foundation

struct BoxOfficeInformationDTO: Codable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [BoxOfficeMovieDTO]
    
    func toDomain() -> BoxOfficeInformation {
        let movies = dailyBoxOfficeList.map { $0.toDomain() }
        
        return BoxOfficeInformation(
            boxOfficeType: boxofficeType,
            targetDate: showRange,
            boxOfficeMovies: movies
        )
    }
}


