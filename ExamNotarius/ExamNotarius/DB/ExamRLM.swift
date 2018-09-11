//
//  ExamRLM.swift
//  ExamNotarius
//
//  Created by Александр on 06.04.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

import Foundation
import RealmSwift

class ExamsRLM: Object {
    @objc dynamic var id : Int = 0
    @objc dynamic var title : String = ""
    @objc dynamic var countQuest : Int = 0
    var quests = List<QuestRLM>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(_ exam:ExamsModel) {
        self.init()
        id = exam.id
        title = exam.name
        countQuest = exam.countQuest
        for questIter in exam.exam {
            let quest = QuestRLM(questIter)
            quests.append(quest)
        }
    }
}
