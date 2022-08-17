import Foundation

struct BoxOfficeResultDTO: Codable {
    let boxOfficeResult: BoxOfficeInformationDTO
    
    func toDomain() -> BoxOfficeInformation {
        return boxOfficeResult.toDomain()
    }
}
