//
//  Exam.swift
//  ExamNotarius
//
//  Created by Александр on 08.04.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

import Foundation
import RealmSwift

protocol ExamManagerDelegate {
    func selectQuest(quest: QuestRLM?, doneQuest: ExamItemRLM?, error: Error?)
}

class ExamManager {
//    var mdata: MData = MData()
    var store = MData.sharedInstance
    var quests: [QuestRLM] = []
    var delegate: ExamManagerDelegate?
    var exam: ExamsRLM = ExamsRLM()
    var currentQuest: QuestRLM?
    var uuid: String = ""
    var examSession: ExamSessionRLM = ExamSessionRLM()
    
    init(_ exam: ExamsRLM) {
        self.exam = exam
        self.quests = Array(self.exam.quests).shuffled
        self.currentQuest = self.quests[0]
        self.uuid = NSUUID().uuidString
    }
    
    func startExam() {
        self.delegate?.selectQuest(quest: self.currentQuest, doneQuest: nil, error: nil)
        if let session = ExamSessionRLM.newExam(self.uuid) {
            self.examSession = session
        }
    }
    
    func nextQuest() {
        if let quest = self.currentQuest {
            self.currentQuest = self.quests.next(item: quest)
            self.checkDoneQuest()
        } // else много лишнего кода
    }
    
    func prevQuest() {
        if let quest = self.currentQuest {
            self.currentQuest = self.quests.prev(item: quest)
            self.checkDoneQuest()
        } // else
    }
    
    func update(answers: [Character]) {
        if let session = ExamSessionRLM.updateSession(self.uuid, idQuest: (self.currentQuest?.id)!, answers: answers) {
            self.examSession = session            
        } 
    }
    
    func checkDoneQuest() {
        if let doneQuest = ExamSessionRLM.getDoneQuest(id: (self.currentQuest?.id)!, uuid: self.uuid) {
            self.delegate?.selectQuest(quest: self.currentQuest, doneQuest: doneQuest, error: nil)
        } else {
            self.delegate?.selectQuest(quest: self.currentQuest, doneQuest: nil, error: nil)
        }
    }
}
