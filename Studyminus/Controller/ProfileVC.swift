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
        guard Auth.auth().currentUser != nil else {return}
        userEmail = Auth.auth().currentUser!.email!
        userId = Auth.auth().currentUser!.uid
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        var ref: DocumentReference? = nil
        currentUser = User(
            email: userEmail, id: userId, username: nameTxt.text, profileImg: "", selfIntro: selfintroTxt.text)
        let updateData = User.modelToData(user: currentUser)

        ref = db.collection("users").addDocument(data: updateData) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
}
