import Foundation
import Alamofire
import CodableAlamofire

class APIClient {
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T>)->Void) -> DataRequest {
        return Alamofire.request(route).responseDecodableObject (decoder: decoder){ (response: DataResponse<T>) in
                completion(response.result)
        }
    }
    
    static func login(username: String, password: String, completion:@escaping (Result<TokenModel>)->Void) {
        performRequest(route: APIRouter.login(username: username, password: password), completion: completion)
    }
    
    static func profile(token : String, user_id : Int, completion : @escaping (Result<UserModel>)->Void) {
        performRequest(route: APIRouter.profile(token: token, user_id: user_id), completion: completion)
    }
}
