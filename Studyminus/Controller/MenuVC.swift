//
//  MenuVC.swift
//  Studyminus
//
//  Created by Keisuke Horiguchi on 2020/11/15.
//

import UIKit
import Firebase

class MenuVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var dataList = ["マイページ", "ログアウト"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
}

extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cellname", for: indexPath)
        cell.textLabel!.text = dataList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let targetVC = self.storyboard!.instantiateViewController(withIdentifier: "ProfileVC")
            moveVC(targetVC: targetVC)
        }
        if indexPath.row == 1{
            logout()
            let targetVC = self.storyboard!.instantiateViewController(withIdentifier: "LoginVC")
            moveVC(targetVC: targetVC)
        }
    }
    
    func logout(){
        guard Auth.auth().currentUser != nil else { return }
            do {try Auth.auth().signOut()
            } catch {
                debugPrint(error)
            }
        }
    func moveVC(targetVC: UIViewController) {
        targetVC.modalTransitionStyle = .crossDissolve
        targetVC.modalPresentationStyle = .fullScreen
        self.present(targetVC, animated: true, completion: nil)
    }
}
