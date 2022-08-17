import Foundation

enum EndPoint {
    private static let searchMainPath = "https://openapi.naver.com/v1/search/movie.json"
    private static let chartMainPath = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    
    case movieSearch(word: String, displayCount: Int = 20)
    case movieChart(date: String)

    var url: URL? {
        switch self {
        case .movieSearch(let word, let display):
            var components = URLComponents(string: EndPoint.searchMainPath)
            let searchWord = URLQueryItem(name: "query", value: "\(word)")
            let display = URLQueryItem(name: "display", value: "\(display)")
            components?.queryItems = [searchWord, display]
            
            return components?.url
            
        case .movieChart(let date):
            var components = URLComponents(string: EndPoint.chartMainPath)
            let searchWord = URLQueryItem(name: ClientInformation.Chart.key, value: ClientInformation.Chart.value)
            let display = URLQueryItem(name: "targetDt", value: "\(date)")
            components?.queryItems = [searchWord, display]
            
            return components?.url
        }
    }
}
