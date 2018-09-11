import Foundation

struct UserModel: Decodable {
    let id: Int
    let username: String
    let toExams: [ExamsModel]
    
    private enum UserModel: String, CodingKey {
        case id
        case name
        case toExams
    }
}

