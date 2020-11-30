//
//  UserRepository.swift
//  Studyminus
//
//  Created by 吉澤翔吾 on 2020/11/30.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserRepository {
    static let shared = UserRepository()
    var currentUser: FirebaseAuth.User!
    
    private static let usersPath = "users"
    private init() {startStateSubscribe()}
    private let db = Firestore.firestore()
    
    private func startStateSubscribe() {
        Auth.auth().addStateDidChangeListener {(auth, user) in
            guard let user: FirebaseAuth.User = user else {
                #warning("nilの場合には、ログイン状態が変わった可能性があるため、Notificationなどでイベントを通知し、ログイン画面に戻す処理が必要。")
                return
            }
            self.currentUser = user
        }
    }
    
    func get(_ handler: @escaping (User?) -> Void) {
        guard let currentUser = currentUser else {
            handler(nil)
            return
        }
        
        let userCollectionRef = db.collection(UserRepository.usersPath)
        userCollectionRef.document(currentUser.uid).getDocument { (snapshot, error) in
            if let error = error {
                print("Error adding document: \(error)")
                handler(nil)
            } else {
                if let user = try? Firestore.Decoder().decode(User.self, from: snapshot!.data()!) {
                    print("getUser Success: \(currentUser.uid)")
                    handler(user)
                } else {
                    print("Decode fail")
                    //Decodeに失敗する場合にはアプリをクラッシュさせる。理由はもしも落ちたらプログラムに問題があるため、開発時に直せるようにするため
                    abort()
                }
            }
        }
        
    }
    
    func create(user: User, image: UIImage, complition:@escaping (Bool) -> Void) {
        var user = user
        guard let imageData = image.jpegData(compressionQuality: 0.2) else { return }
        
        let imageRef = Storage.storage().reference().child("/userImages/\(currentUser.uid).jpg")
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        imageRef.putData(imageData, metadata: metaData) { (metaData, error) in
            if let error = error {
                print("Unable to upload image. detail: \(error)")
                complition(false)
                return
            }
            imageRef.downloadURL { (url, error) in
                if let error = error {
                    print("Unable to download url. detail: \(error)")
                    complition(false)
                    return
                }
                guard let url = url else { return }
                //↓これが行われるのが遅過ぎて、適切なURLを保存できない。あーだからステータスのモニタリングの話がFire baseのサイトで出てたのかも。
                user.profileImg = url.absoluteString
                do {
                    try self.db.collection("users").document(self.currentUser.uid).setData(from: user, merge: true)
                    complition(true)
                } catch {
                    abort()
                }
            }
        }
    }
    
    func update() {
        
    }
}
