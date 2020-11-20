//
//  Setting.swift
//  Studyminus
//
//  Created by Keisuke Horiguchi on 2020/11/19.
//

import Foundation
import UIKit
import Firebase

extension String {
    var isNotEmpty : Bool {
        return !isEmpty
    }
}

extension UIViewController {
    func simpleAlert(title:String, msg:String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

class Userservice{
    func logout(){
        guard let user = Auth.auth().currentUser else { return }
        
        if user.isAnonymous {
            presentLoginController()
        } else {
            do {
                try Auth.auth().signOut()
                Userservices.logoutUser()
                Auth.auth().signInAnonymously { (result, error) in
                    if let error = error {
                        Auth.auth().handlerFireAuthError(error: error, vc: self)
                        debugPrint(error)
                    }
                    self.presentLoginController()
                }
            } catch {
                Auth.auth().handlerFireAuthError(error: error, vc: self)
                debugPrint(error)
            }
        }
    }
}
