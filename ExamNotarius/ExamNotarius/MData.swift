import Foundation
import Alamofire
import KeychainSwift
import RealmSwift

protocol MDataDelegate {
    func storeChange(user: UserRLM?, error: Error?)
}

class MData {
    static let sharedInstance = MData()
    private let keychain = KeychainSwift()
    
    var delegate: MDataDelegate?    
    var user: UserRLM?
    var token: String?
    var user_id: String?
    
    private init() {
        self.token = self.getFromKeyChain(key: "token")
        self.user_id = self.getFromKeyChain(key: "user_id")        
    }
    
    var getUserQueue = DispatchQueue(label: "com.notariusapp.getUserProfile")

    func saveToKeychain(data : String, key : String) {
        keychain.set(data, forKey: key)
        if key == "token" {
            self.token = data
        } else if key == "user_id" {
            self.user_id = data
        }
    }
    
    private func getFromKeyChain(key : String) -> String? {
        return keychain.get(key)
    }
    
    func getProfileUser(id: Int) {
        if let user = UserRLM.getUser(by: id) {
            self.user = user
            self.delegate?.storeChange(user: self.user, error: nil)
        }
        
        if self.token != nil && self.user_id != nil {
            getUserQueue.async { [weak self] in
                guard let weakself = self else {return}
                APIClient.profile(token: weakself.token!, user_id: Int(weakself.user_id!)!) { result in
                    switch result {
                    case .success(let data):
                        UserRLM.updateProfileUser(data)
                        weakself.user = UserRLM.getUser(by: data.id)                        
                        weakself.delegate?.storeChange(user: weakself.user, error: nil)
                    case .failure(let error):                        
                        weakself.delegate?.storeChange(user: nil, error: error)
                    }
                }
            }
        }
    }
}
