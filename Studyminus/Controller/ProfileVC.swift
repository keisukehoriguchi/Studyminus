//
//  ProfileVC.swift
//  Studyminus
//
//  Created by Keisuke Horiguchi on 2020/11/15.
//

import UIKit
import Kingfisher

class ProfileVC: UIViewController {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var nameTxt: UITextView!
    @IBOutlet weak var selfLbl: UILabel!
    @IBOutlet weak var selfintroTxt: UITextView!
    @IBOutlet weak var subjectCollection: UICollectionView!
    
    var userEmail:String = ""
    var userId:String = ""
    var updateData = [String: Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgTapped))
        tap.numberOfTouchesRequired = 1
        profileImg.isUserInteractionEnabled = true
        profileImg.clipsToBounds = true
        profileImg.addGestureRecognizer(tap)
        
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        #warning("入力項目の内容がちゃんと入っているかどうか等のバリデーションが必要。場合によってはエラーアラート表示")
        guard let image = profileImg.image else { return }
        let user = User(
            email: userEmail, id: userId, username: nameTxt.text, profileImg: "", selfIntro: selfintroTxt.text)
        UserRepository.shared.create(user: user, image: image) { isSucess in
            if !isSucess {
                #warning("エラー処理")
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

