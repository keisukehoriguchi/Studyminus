//
//  ProfileVC.swift
//  Studyminus
//
//  Created by Keisuke Horiguchi on 2020/11/15.
//

import UIKit
import Firebase

class ProfileVC: UIViewController {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var nameTxt: UITextView!
    @IBOutlet weak var selfLbl: UILabel!
    @IBOutlet weak var selfintroTxt: UITextView!
    @IBOutlet weak var subjectCollection: UICollectionView!
    
    var currentUser = User()
    var userEmail:String = ""
    var userId:String = ""
    let db = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().addStateDidChangeListener { [self] (auth, user) in
            if user != nil {
                userEmail = user?.email ?? ""
                userId = user?.uid ?? ""
                
                let docRef = db.collection("users").document(userId)
                
                docRef.getDocument { (document, error) in
                    if let user = document.flatMap({
                        $0.data().flatMap({ (data) in
                            return User(data: data)
                        })
                    }) {
                        print("User: \(user)")
                    } else {
                        print("Document does not exist")
                    }
                }
            }
        }
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        currentUser = User(
            email: userEmail, id: userId, username: nameTxt.text, profileImg: "", selfIntro: selfintroTxt.text)
        let updateData = User.modelToData(user: currentUser)
        db.collection("users").document(currentUser.id).setData(updateData)
    }
}


