import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case login(username : String, password : String)
    case profile(token : String, user_id : Int)
    case exams(token : String)
//    case posts
//    case post(id: Int)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .exams:
            return .get
        case .profile:
            return .get
//        case .posts, .post:
//            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .login:
            return "/api-token-auth/"
        case .exams:
            return "/api_v1/exams/"
        case .profile:
            return "/api_v1/profile/1/"
//        case .posts:
//            return "/posts"
//        case .post(let id):
//            return "/posts/\(id)"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .login(let username, let password):
            return [K.APIParameterKey.username: username, K.APIParameterKey.password: password]
        case .exams, .profile:
            return nil
//        case .posts, .post:
//            return nil
        }
    }
    
    private var httpHead : String? {
        switch self {
        case .login:
            return nil
        case .exams(let token):
            return "JWT \(token)"
        case .profile(let token, _):
            return "JWT \(token)"
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try K.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        if let httpHead = httpHead {
            urlRequest.setValue(httpHead, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        }
        
        return urlRequest
    }
}
