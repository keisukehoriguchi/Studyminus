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
    
    let storage = Storage.storage()
    
    
    
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
                        currentUser = user
                        updateScreen(user: currentUser)
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
    
    func updateScreen(user: User) {
        nameTxt.text = currentUser.username
        selfintroTxt.text = currentUser.selfIntro
    }
    
    func updateImage() {
        
        let storageRef = storage.reference()
        // File located on disk
        let localFile = URL(string: "path/to/image")!

        // Create a reference to the file you want to upload
        let profileImgRef = storageRef.child("images/\(currentUser.id).jpg")

        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = profileImgRef.putFile(from: localFile, metadata: nil) { metadata, error in
          guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            return
          }
          // Metadata contains file metadata such as size, content-type.
          let size = metadata.size
          // You can also access to download URL after upload.
            profileImgRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
              // Uh-oh, an error occurred!
              return
            }
            self.currentUser.profileImg = downloadURL.absoluteString
          }
        }
    }
}


