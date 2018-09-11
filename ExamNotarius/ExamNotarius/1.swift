//
//  ViewController.swift
//  ExamNotarius
//
//  Created by Александр on 07.03.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    var user : UserRealm = UserRealm()
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordFiled: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        let user_id = MData.shared.getFromKeyChain(key: "user_id")
        let token = MData.shared.getFromKeyChain(key: "token")
        if token != nil && user_id != nil  {
            self.checkLoginedUser(token: token!, user_id: Int(user_id!)!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Enter(_ sender: Any) {
        if usernameField.text!.isEmpty || passwordFiled.text!.isEmpty {
            showAlert(msg: "Please fill in all the fields we can get you logged in to your account.")
        } else {
            APIClient.login(username: usernameField.text!, password: passwordFiled.text!) { result in
                switch result {
                case .success(let result):
                    MData.shared.saveToKeychain(data: String(result.user_id), key: "user_id")
                    MData.shared.saveToKeychain(data: result.token, key: "token")
                    self.checkLoginedUser(token: result.token, user_id : result.user_id)
                case .failure(let error):
                    print(error.localizedDescription)
                    self.showAlert(msg: "Please fill in all the fields we can get you logged in to your account.")
                }
            }
        }
    }
    
    func checkLoginedUser(token : String, user_id : Int) {
        APIClient.profile(token: token, user_id: user_id) { result in
            switch result {
            case .success(let data):
                self.user = MData.shared.updateProfile(data : data)
                self.performSegue(withIdentifier: "home", sender: self)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func showAlert(msg: String) {
        let alert = UIAlertController(title: "Ошибка!", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "home" {
            let destVC: ProfileViewController = segue.destination as! ProfileViewController
            destVC.user = self.user
        }
    }
}


