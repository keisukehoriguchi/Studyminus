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

class Userservices{
    func logout(){
        guard Auth.auth().currentUser != nil else { return }
            do {try Auth.auth().signOut()
            } catch {
                debugPrint(error)
            }
        }
}
