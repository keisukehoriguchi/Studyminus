//
//  AddTaskVC.swift
//  Studyminus
//
//  Created by Keisuke Horiguchi on 2020/11/29.
//

import UIKit
import Firebase
import Kingfisher

class AddTaskVC: UIViewController {
    
    @IBOutlet weak var taskNameTxt: UITextField!
    @IBOutlet weak var taskDetailTxt: UITextView!
    @IBOutlet weak var taskImg: UIImageView!
    var updateSubject = Subject()
    var updateData = [String: Any]()
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgTapped))
        tap.numberOfTouchesRequired = 1
        taskImg.isUserInteractionEnabled = true
        taskImg.clipsToBounds = true
        taskImg.addGestureRecognizer(tap)
    }
    
    @IBAction func registerBtn(_ sender: Any) {
        uploadImageThenDocument()
        self.dismiss(animated: true, completion: nil)
    }
}

//画像保存func
extension AddTaskVC {
    func uploadImageThenDocument() {
        guard let image = taskImg.image else { return }
        guard let imageData = image.jpegData(compressionQuality: 0.2) else { return }
        
        let imageRef = Storage.storage().reference().child("/subjectImg/\(taskNameTxt.text).jpg")
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
                guard let name = self.taskNameTxt.text, let detail = self.taskDetailTxt.text else { return }
                self.updateSubject = Subject(name: name, detail: detail, subjectImg: "", userid: UserRepository.shared.currentUser.uid)
                self.updateSubject.subjectImg = url.absoluteString
                self.updateData = Subject.modelToData(subject: self.updateSubject)
                self.db.collection("Posts").addDocument(data: self.updateData)
            }}}
}

extension AddTaskVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
        taskImg.contentMode = .scaleAspectFill
        taskImg.image = image
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

