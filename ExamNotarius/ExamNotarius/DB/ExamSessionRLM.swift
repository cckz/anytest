//
//  ExamSessionRLM.swift
//  ExamNotarius
//
//  Created by Александр on 08.04.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

import Foundation
import RealmSwift

class ExamSessionRLM: Object {
    @objc dynamic var id: String = ""
    var questsDone = List<ExamItemRLM>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(_ uuid: String) {
        self.init()
        id = uuid
    }
    
    class func newExam(_ uuid: String) -> ExamSessionRLM? {
        var exam: ExamSessionRLM?
        do {
            let realm = try Realm()
            exam = ExamSessionRLM(uuid)
            realm.beginWrite()
            realm.add(exam!, update: true)
            try realm.commitWrite()
        } catch {
            exam = nil
            print("error \(error)")
        }
        return exam
    }
    
    class func updateSession(_ uuid: String, idQuest: Int, answers: [Character]) -> ExamSessionRLM? {
        var updateSession: ExamSessionRLM?
        do {
            let realm = try Realm()
            let condition = NSPredicate(format: "id ==%@", uuid)
            let session = realm.objects(ExamSessionRLM.self).filter(condition)
            if let sessionTMP = session.first {
                updateSession = sessionTMP
                let newExamItem = ExamItemRLM(idQuest)
                for answ in answers {
                    let rAnswer = RightAnswerRLM(answ.id)
                    newExamItem.doneAnswers.append(rAnswer)
                }                
                try! realm.write {
                    updateSession?.questsDone.append(newExamItem)
                }
            } else {
                updateSession = nil
            }
        } catch {
            updateSession = nil
            print("error \(error)")
        }
        return updateSession
    }
    
    class func getDoneQuest(id: Int, uuid: String) -> ExamItemRLM? {
        var doneQuest: ExamItemRLM?
        do {
            let realm = try Realm()
            var condition = NSPredicate(format: "id ==%@", uuid)
            let session = realm.objects(ExamSessionRLM.self).filter(condition)
            if let sessionTMP = session.first {
                condition = NSPredicate(format: "idQuest == %@", NSNumber(value: id))
                let getQuest = sessionTMP.questsDone.filter(condition)
                if let item  = getQuest.first {
                    doneQuest = item
                }
            }
        } catch {
            print("error \(error)")
        }
        return doneQuest
    }
}

class ExamItemRLM: Object {
    @objc dynamic var idQuest: Int = 0
    var doneAnswers = List<RightAnswerRLM>()
    
    convenience init(_ id: Int) {
        self.init()
        idQuest = id
    }    
}


