import Foundation

struct K {
    struct ProductionServer {
        static let baseURL = "http://anytest.pythonanywhere.com/"
    }
    
    struct APIParameterKey {
        static let password = "password"
        static let username = "username"
    }    
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
