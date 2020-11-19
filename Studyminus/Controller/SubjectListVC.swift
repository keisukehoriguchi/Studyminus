//
//  SubjectListVC.swift
//  Studyminus
//
//  Created by Keisuke Horiguchi on 2020/11/15.
//

import UIKit
import SideMenuSwift

class SubjectListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    

    @IBAction func menuClicked(_ sender: Any) {
        self.sideMenuController?.revealMenu()
    }
    
}
