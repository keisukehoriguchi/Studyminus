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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgTapped))
        tap.numberOfTouchesRequired = 1
        profileImg.isUserInteractionEnabled = true
        profileImg.clipsToBounds = true
        profileImg.addGestureRecognizer(tap)
        
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
                    }}}}
        
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        currentUser = User(
            email: userEmail, id: userId, username: nameTxt.text, profileImg: "", selfIntro: selfintroTxt.text)
        uploadImageThenDocument()
        let updateData = User.modelToData(user: currentUser)
        db.collection("users").document(currentUser.id).setData(updateData)
    }
    
    func updateScreen(user: User) {
        nameTxt.text = currentUser.username
        selfintroTxt.text = currentUser.selfIntro
    }
}

//画像処理型

extension ProfileVC {
    
    func uploadImageThenDocument() {
        guard let image = profileImg.image else { return }
        guard let imageData = image.jpegData(compressionQuality: 0.2) else { return }
        
        let imageRef = Storage.storage().reference().child("/userImages/\(currentUser.id).jpg")
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        imageRef.putData(imageData, metadata: metaData) { (metaData, error) in
            if let error = error {
                print("Unable to upload image. detail: \(error)")
                return
            }
            
            imageRef.downloadURL { (url, error) in
                if let error = error {
                    print("Unable to download url. detail: \(error)")
                    return
                }
                
                guard let url = url else { return }
                self.currentUser.profileImg = url.absoluteString
            }
        }
    }
}

//TapによるPicker表示周辺

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func imgTapped() {
        launchImagePicker()
    }
    
    func launchImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        profileImg.contentMode = .scaleAspectFill
        profileImg.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
//    func updateImage() {
//        let storageRef = storage.reference()
//        // File located on disk
//        let localFile = URL(string: "path/to/image")!
//
//        // Create a reference to the file you want to upload
//        let profileImgRef = storageRef.child("images/\(currentUser.id).jpg")
//
//        // Upload the file to the path "images/rivers.jpg"
//        let uploadTask = profileImgRef.putFile(from: localFile, metadata: nil) { metadata, error in
//            guard let metadata = metadata else {
//                // Uh-oh, an error occurred!
//                return
//            }
//            // Metadata contains file metadata such as size, content-type.
//            let size = metadata.size
//            // You can also access to download URL after upload.
//            profileImgRef.downloadURL { (url, error) in
//                guard let downloadURL = url else {
//                    // Uh-oh, an error occurred!
//                    return
//                }
//                self.currentUser.profileImg = downloadURL.absoluteString
//            }}}
}

