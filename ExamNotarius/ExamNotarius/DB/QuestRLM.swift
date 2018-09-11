//
//  QuestRLM.swift
//  ExamNotarius
//
//  Created by Александр on 06.04.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

import Foundation
import RealmSwift

class QuestRLM: Object {
    @objc dynamic var id : Int = 0
    @objc dynamic var quest : String = ""
    var rightAnswer = List<RightAnswerRLM>()
    var answers = List<AnswerRLM>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(_ questIN:QuestModel) {
        self.init()
        id = questIN.id
        quest = questIN.quest
        
        for answ in questIN.answers {
            let answer = AnswerRLM(answ)
            answers.append(answer)
        }
        
        for rightAnsw in questIN.rightAnswers {
            let rAnsw = RightAnswerRLM(rightAnsw)
            rightAnswer.append(rAnsw)
        }
    }
}
