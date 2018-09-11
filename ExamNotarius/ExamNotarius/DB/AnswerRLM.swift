//
//  AnswerRLM.swift
//  ExamNotarius
//
//  Created by Александр on 06.04.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

import Foundation
import RealmSwift

class AnswerRLM: Object {
    @objc dynamic var id : Int = 0
    @objc dynamic var answer : String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(_ answerIN:AnswerModel) {
        self.init()
        id = answerIN.id
        answer = answerIN.answer
    }
}

class RightAnswerRLM: Object {
    @objc dynamic var ID : Int = 0
    
    convenience init(_ idAnsw: Int) {
        self.init()
        ID = idAnsw
    }
}
