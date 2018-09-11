import Foundation

struct ExamsModel: Decodable {
    let id: Int
    let name: String    
    let countQuest: Int
    let exam: [QuestModel]

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case countQuest
        case exam
    }
}

struct QuestModel: Decodable {
    let id: Int
    let quest: String
    let answers: [AnswerModel]
    let rightAnswers: [Int]
    
    private enum CodingKeys: String, CodingKey {
        case id
        case quest
        case answers
        case rightAnswers
    }
}

struct AnswerModel: Decodable {
    let id: Int
    let answer: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case answer
    }
}
