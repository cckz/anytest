//
//  ProfileViewController.swift
//  ExamNotarius
//
//  Created by Александр on 11.03.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

import UIKit
import KeychainSwift
import RealmSwift

extension ProfileViewController: LoginViewControllerDelegate {

}

extension ProfileViewController: MDataDelegate {
    
}

class ProfileViewController: UIViewController, UITableViewDataSource {
    var loggedIn: Bool = false
    var user: UserRLM = UserRLM()
    let store = MData.sharedInstance
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//      print(Realm.Configuration.defaultConfiguration.fileURL!)
//        let keychain = KeychainSwift()
//        keychain.clear()
        store.delegate = self
        tableView.dataSource = self
        if store.user_id != nil && store.token != nil {
            store.getProfileUser(id: Int(store.user_id!)!)
        }
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if self.loggedIn == false {
            let loginStotyBoard = UIStoryboard(name: "Login", bundle: Bundle.main)
            if let loginVC = loginStotyBoard.instantiateInitialViewController() as? LoginViewController {
                loginVC.delegate = self
                present(loginVC, animated: true, completion: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.user.exam.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        cell.titleExamLabel.text = self.user.exam[indexPath.row].title
        cell.countQuestsLabel.text = "Вопросов: \(self.user.exam[indexPath.row].countQuest)"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "beginExam" {
            if let IndexPath = tableView.indexPathForSelectedRow {
                let examVC = segue.destination as! ExamViewController
                examVC.exam = self.user.exam[IndexPath.row]
            }
        }
    }
    
    func showAlert(msg: String) {
        let alert = UIAlertController(title: "Ошибка!", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func didLoggenIn(success: Bool) {
        self.loggedIn = success
        if loggedIn == true {
            store.getProfileUser(id: Int(store.user_id!)!)
        }
    }
    
    func storeChange(user: UserRLM?, error: Error?) {
        if let userTMP = user {
            self.loggedIn = true
            self.user = userTMP
            usernameLabel.text = self.user.username
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } else if let error = error {
            print(error.localizedDescription)
            let msg = "Нет соединения с сервером"
            showAlert(msg: msg)
        }
    }
}
