import Foundation

enum ClientInformation {
    enum Search {
        enum ID {
            static let key = "X-Naver-Client-Id"
            static let value = "xIDxQUaIwFGS6sVcbAyN"
        }
        
        enum Secret {
            static let key = "X-Naver-Client-Secret"
            static let value = "MsuEr9QhRX"
        }
        
        static let headerValue: [String: String] = [
            ID.key: ID.value,
            Secret.key: Secret.value
        ]
    }
    
    enum Chart {
        static let key = "key"
        static let value = "740b56960b31cef6e23410f905409a3d"
    }
}
