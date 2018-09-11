//
//  ResultsTableViewController.swift
//  ExamNotarius
//
//  Created by Александр on 26.04.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    var examManager: ExamManager?
    var rightAnswerArray: [QuestRLM] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Вернуться", style: .done, target: self, action: #selector(self.backHome))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examManager!.quests.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath)
        cell.textLabel?.text = "Вопрос \(indexPath.row + 1)"
        let quest = examManager!.quests[indexPath.row]
        var rAnswers = [Int]()
        for rAnsw in quest.rightAnswer {
            rAnswers.append(rAnsw.ID)
        }
        if let userAnswerTMP = self.checkAnswer(quest: quest)?.doneAnswers {
            var userAnswers = [Int]()
            for userAnsw in userAnswerTMP {
                userAnswers.append(userAnsw.ID)
            }
            if Set(userAnswers) == Set(rAnswers) {
                cell.backgroundColor = UIColor.green
                rightAnswerArray.append(quest)
            } else {
                cell.backgroundColor = UIColor.red
            }
        }
        return cell
    }
    
    func checkAnswer(quest: QuestRLM) -> ExamItemRLM? {
        return self.examManager!.examSession.questsDone.first(where: {
            $0.idQuest == quest.id
        })
    }
    
    @objc func backHome(sender: AnyObject) {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResults" {
            if let IndexPath = tableView.indexPathForSelectedRow {
                let resultsVC = segue.destination as! ExamViewController
                let quest = self.examManager!.quests[IndexPath.row]
                resultsVC.results = quest
                resultsVC.doneQuest = self.checkAnswer(quest: quest)
                resultsVC.navigationBar.title = "Вопрос \(IndexPath.row + 1)"
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    

}
