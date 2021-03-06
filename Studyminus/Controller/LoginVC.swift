//
//  LoginVC.swift
//  Studyminus
//
//  Created by Keisuke Horiguchi on 2020/11/15.
//

import UIKit
import Firebase
import SideMenuSwift

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        
        guard let email = emailTxt.text, email.isNotEmpty,
              let password = passwordTxt.text, password.isNotEmpty else {
            simpleAlert(title: "Error", msg: "Please fill out all field.")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password){ [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if let error = error {
                debugPrint(error)
                return
            }
            guard let storyboard = self?.storyboard else {
                return
            }
            UserRepository.shared.get { userInfo in
                if let userInfo = userInfo {
                    SideMenuController.preferences.basic.direction = .right
                    SideMenuController.preferences.basic.menuWidth = 280
                    let contentViewController = storyboard.instantiateViewController(withIdentifier: "SubjectListVC")
                    let menuViewController = storyboard.instantiateViewController(withIdentifier: "MenuVC")
                    let viewController = SideMenuController(contentViewController: contentViewController,menuViewController: menuViewController)
                    viewController.modalTransitionStyle = .crossDissolve
                    viewController.modalPresentationStyle = .fullScreen
                    self?.present(viewController, animated: true, completion: nil)
                } else {
                    let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileVC")
                    profileVC.modalTransitionStyle = .crossDissolve
                    profileVC.modalPresentationStyle = .fullScreen
                    self?.present(profileVC, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func loginbyAIDClicked(_ sender: Any) {
        print(Auth.auth().currentUser)
    }
    
}
