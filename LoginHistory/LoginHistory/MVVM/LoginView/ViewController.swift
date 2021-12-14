//
//  ViewController.swift
//  LoginHistory
//
//  Created by Lyvennitha on 14/12/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = DatabaseController.getAllShows().count
        return data
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? LoginTableCell
        let data = DatabaseController.getAllShows()[indexPath.row]//self.contactData?[indexPath.row]
        cell?.userName.text = "\(data.firstName ?? "") \(data.lastName ?? "")"
        cell?.email.text = data.email
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "HH:mm E, d MMM y"
       // print(formatter1.string(from: data.date ?? Date()))
        cell?.date.text = formatter1.string(from: data.date ?? Date())
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
}

class LoginTableCell: UITableViewCell{
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var date: UILabel!
}
