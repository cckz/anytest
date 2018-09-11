import Foundation

struct TokenModel: Decodable {
    let token: String
    let user_id: Int
    
    private enum CodingKeys: String, CodingKey {
        case token
        case user_id
    }
}
