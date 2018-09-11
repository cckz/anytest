//
//  ExamViewController.swift
//  ExamNotarius
//
//  Created by Александр on 20.03.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

import UIKit

extension ExamViewController: ExamManagerDelegate {
    
}

class ExamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var examManager: ExamManager?
    var exam: ExamsRLM?
    var currentQuest: QuestRLM = QuestRLM()
    var answers: [Character] = []
    var doneQuest: ExamItemRLM?
    var countQuest: Int = Int()
    var results: QuestRLM?
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var questTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneButton: UIBarButtonItem!    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let exTMP = exam {
            examManager = ExamManager(exTMP)
            examManager?.delegate = self
            countQuest = exTMP.countQuest
            examManager?.startExam()
        }
        navigationBar.hidesBackButton = true
        
        if let resultsTPM = results {
            self.selectQuest(quest: resultsTPM, doneQuest: doneQuest, error: nil)
//            self.doneQuest = doneQuest
            navigationBar.hidesBackButton = false
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        questTextView.isUserInteractionEnabled = false
        self.tableView.tableFooterView = UIView()        
    }
    
    func selectQuest(quest: QuestRLM?, doneQuest: ExamItemRLM?, error: Error?) {
        if let questTMP = quest {
            currentQuest = questTMP
            questTextView.text = currentQuest.quest            
            answers = []
            for answer in currentQuest.answers {
                answers.append(Character(title: answer.answer, id: answer.id))
            }
            if let indexOfQuest = examManager?.quests.index(of: self.currentQuest) {
                navigationBar.title = "Вопрос \(indexOfQuest+1)/\(countQuest)"
            }
        }
        
        if let doneTMP = doneQuest {
            if doneTMP.idQuest == currentQuest.id {
                self.doneQuest = doneTMP
                if results == nil {
                    doneButton.isEnabled = false
                }                
            }
        } else {
            self.doneQuest = nil
            doneButton.isEnabled = true
        }
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "answer", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = answers[indexPath.row].title
        cell.isUserInteractionEnabled = true
        if let done = doneQuest {
            if done.doneAnswers.contains(where: { $0.ID == answers[indexPath.row].id }) {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            cell.isUserInteractionEnabled = false
        } else {
            if answers[indexPath.row].isSelected {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        answers[indexPath.row].isSelected = !answers[indexPath.row].isSelected
        tableView.reloadData()
    }
    
    @IBAction func nextQuest(_ sender: Any) {
        examManager?.nextQuest()
    }
    
    @IBAction func prevQuest(_ sender: Any) {
        examManager?.prevQuest()
    }
   
    @IBAction func done(_ sender: Any) {
        let selected = answers.filter { $0.isSelected == true}
        if selected.count > 0 {
            examManager?.update(answers: selected)
            if exam?.countQuest == examManager?.examSession.questsDone.count {
                let user = MData.sharedInstance.user!
                UserRLM.newExamSession(user, examSession: (examManager?.examSession)!)
                performSegue(withIdentifier: "results", sender: nil)
            } else {
                examManager?.nextQuest()
            }
        } else {
            showAlert(msg: "Ответьте на вопрос")
        }
    }
    
    func showAlert(msg: String) {
        let alert = UIAlertController(title: "Ошибка!", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "results" {
            let resultsVC = segue.destination as! ResultsTableViewController
            resultsVC.examManager = self.examManager
        }
    }
}
