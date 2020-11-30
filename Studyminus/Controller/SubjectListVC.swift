//
//  SubjectListVC.swift
//  Studyminus
//
//  Created by Keisuke Horiguchi on 2020/11/15.
//

import UIKit
import Firebase
import SideMenuSwift

class SubjectListVC: UIViewController {
    
    @IBOutlet weak var subjectTable: UITableView!
    var subjects:[Subject] = []
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        subjectTable.delegate = self
        subjectTable.dataSource = self
        
        db.collection("Posts").getDocuments { (querySnapshot, error) in
            self.subjects = []
            if let error = error{
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    let update = Subject(document: document)
                    self.subjects.append(update)
                }
            }
            self.subjectTable.reloadData()
        }
    }

    
    @IBAction func menuClicked(_ sender: Any) {
        self.sideMenuController?.revealMenu()
    }
}

extension SubjectListVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = subjectTable.dequeueReusableCell(withIdentifier: "SJCell", for: indexPath) as! SubjectTableViewCell
        cell.configureCell(subject: subjects[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
        }
    
}


