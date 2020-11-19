//
//  LoginVC.swift
//  Studyminus
//
//  Created by Keisuke Horiguchi on 2020/11/15.
//

import UIKit
import SideMenuSwift

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        
        guard let storyboard = storyboard else {
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
        
    }
    
    @IBAction func loginbyAIDClicked(_ sender: Any) {
    }
    
}
