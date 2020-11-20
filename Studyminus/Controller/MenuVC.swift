//
//  MenuVC.swift
//  Studyminus
//
//  Created by Keisuke Horiguchi on 2020/11/15.
//

import UIKit
import Firebase

class MenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var dataList = ["マイページ", "ログアウト"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
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
            let targetViewController = self.storyboard!.instantiateViewController(withIdentifier: "ProfileVC")
            self.present(targetViewController, animated: true, completion: nil)
        }
        if indexPath.row == 1{
            let targetViewController = self.storyboard!.instantiateViewController(withIdentifier: "LoginVC")
            
            self.present(targetViewController, animated: true, completion: nil)
        }
    }
    
}
