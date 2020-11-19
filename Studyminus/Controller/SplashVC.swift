//
//  ViewController.swift
//  Studyminus
//
//  Created by Keisuke Horiguchi on 2020/11/15.
//

import UIKit
import Firebase

class SplashVC: UIViewController {
    
    //learn by scribble.glyph from the Noun Project (attributtion)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            viewController.modalTransitionStyle = .crossDissolve
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
        }

        
//        let email:String = "jonny@poople.com"
//        let password:String = "123123"
//
//        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
//            if let error = error {
//                debugPrint(error)
//                return
//            }
//        }
    }
}
