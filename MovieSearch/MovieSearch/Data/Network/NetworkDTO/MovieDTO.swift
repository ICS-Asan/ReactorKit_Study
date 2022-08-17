import Foundation

struct MovieDTO: Codable {
    let title: String
    let link: String
    let image: String
    let subtitle: String
    let pubDate: String
    let director: String
    let actor: String
    let userRating: String
    
    func toDomain() -> Movie {
        return Movie(
            title: convertCorrectTitle(from: title),
            link: link,
            image: image,
            subtitle: subtitle,
            pubDate: pubDate,
            director: convertCorrectDirector(from: director),
            actor: convertCorrectActor(from: actor),
            userRating: userRating)
    }
}

extension MovieDTO {
    private func convertCorrectTitle(from previousTitle: String) -> String {
        var convertedTitle = previousTitle.replacingOccurrences(of: "<b>", with: "")
        convertedTitle = convertedTitle.replacingOccurrences(of: "</b>", with: "")
        
        return convertedTitle
    }
    
    private func convertCorrectActor(from previousActor: String) -> String {
        let separatedActors = previousActor.components(separatedBy: "|").dropLast()
        let convertedActor = separatedActors.joined(separator: ", ")

        return convertedActor
    }
    
    private func convertCorrectDirector(from previousDirector: String) -> String {
        let separatedDirector = previousDirector.components(separatedBy: "|").dropLast()
        let convertedDirector = separatedDirector.joined(separator: ", ")

        return convertedDirector
    }
}
