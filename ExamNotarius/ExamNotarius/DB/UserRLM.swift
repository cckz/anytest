import Foundation
import RealmSwift


class UserRLM: Object {
    @objc dynamic var id : Int = 0
    @objc dynamic var username : String = ""
    var exam = List<ExamsRLM>()
    var examSession = List<ExamSessionRLM>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(_ user:UserModel) {
        self.init()
        username = user.username
        id = user.id
    }
    
    class func updateProfileUser(_ user: UserModel) {
        do {
            let realm = try Realm()
            let userTMP = UserRLM(user)
            for examIter in user.toExams {
                let exam = ExamsRLM(examIter)
                userTMP.exam.append(exam)
            }
            realm.beginWrite()
            realm.add(userTMP, update: true)
            try realm.commitWrite()
        } catch {
            print("error \(error)")
        }
    }
    
    class func getUser(by id: Int) -> UserRLM? {
        let user: UserRLM?
        let condition = NSPredicate(format: "id ==%@", NSNumber(value: id))
        do {
            let realm = try Realm()
            let userTMP = realm.objects(UserRLM.self).filter(condition)
            user = userTMP.first
        } catch {
            user = nil
            print("error \(error)")
        }
        return user
    }
    
    class func newExamSession(_ user: UserRLM, examSession: ExamSessionRLM) {
        do {
            let realm = try Realm()
            try! realm.write {
                user.examSession.append(examSession)
            }            
        } catch {
            print("error \(error)")
        }        
    }
}
