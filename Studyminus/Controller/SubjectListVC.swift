//
//  SubjectListVC.swift
//  Studyminus
//
//  Created by Keisuke Horiguchi on 2020/11/15.
//

import UIKit
import SideMenuSwift

class SubjectListVC: UIViewController {
    
    
    @IBOutlet weak var subjectTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func menuClicked(_ sender: Any) {
        self.sideMenuController?.revealMenu()
    }
}

extension SubjectListVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = subjectTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    
    
}


