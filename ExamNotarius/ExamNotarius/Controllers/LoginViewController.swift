//
//  ViewController.swift
//  ExamNotarius
//
//  Created by Александр on 07.03.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

import UIKit
//import RealmSwift

protocol LoginViewControllerDelegate {
    func didLoggenIn(success: Bool)
}

class LoginViewController: UIViewController {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    var delegate: LoginViewControllerDelegate?
    let store = MData.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        backgroundImage.addBlurEffect()
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert(msg: String) {
        let alert = UIAlertController(title: "Ошибка!", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func Sing(_ sender: Any) {
        if usernameField.text!.isEmpty || passwordField.text!.isEmpty {
            showAlert(msg: "Заполенны не все данные.")
        } else {
            APIClient.login(username: usernameField.text!, password: passwordField.text!) { result in
                switch result {
                case .success(let result):                    
                    let token = result.token
                    let user_id = result.user_id
                    self.store.saveToKeychain(data: String(user_id), key: "user_id")
                    self.store.saveToKeychain(data: token, key: "token")
                    self.delegate?.didLoggenIn(success: true)
                    self.dismiss(animated: true, completion: nil)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }    
}


