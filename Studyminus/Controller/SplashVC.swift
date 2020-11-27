//
//  ViewController.swift
//  Studyminus
//
//  Created by Keisuke Horiguchi on 2020/11/15.
//

import UIKit
import Firebase
import SideMenuSwift

class SplashVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            Auth.auth().addStateDidChangeListener { (auth, user) in
                if user != nil {
                    guard let storyboard = self.storyboard else {
                        return
                    }
                    SideMenuController.preferences.basic.direction = .right
                    SideMenuController.preferences.basic.menuWidth = 280
                    let contentViewController = storyboard.instantiateViewController(withIdentifier: "SubjectListVC")
                    let menuViewController = storyboard.instantiateViewController(withIdentifier: "MenuVC")
                    let viewController = SideMenuController(contentViewController: contentViewController,
                                                            menuViewController: menuViewController)
                    viewController.modalTransitionStyle = .crossDissolve
                    viewController.modalPresentationStyle = .fullScreen
                    self.present(viewController, animated: true, completion: nil)
                    return
                } else {
                    
                    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                    viewController.modalTransitionStyle = .crossDissolve
                    viewController.modalPresentationStyle = .fullScreen
                    self.present(viewController, animated: true, completion: nil)
                }
            }
            
        }
    }
}
