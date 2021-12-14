//
//  LoginViewController.swift
//  LoginHistory
//
//  Created by Lyvennitha on 14/12/21.
//

import Foundation
import UIKit
import CoreData

class LoginViewController: UIViewController{
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var resopnse: LoginDataResponse?
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func loginAction(_ sender: UIButton){
        if emailField.text == "" || emailField.text != "shiva2"{
            print("email not correct")
            self.showAlert(alertText: "User Name", alertMessage: emailField.text == "" ? "Empty USeer name":"Wrong user name")
        }else if passwordField.text == "" || passwordField.text != "123123"{
            self.showAlert(alertText: "Password", alertMessage: emailField.text == "" ? "Empty password":"Wrong password")
            print("password not corect")
        }else{
            self.postDetails(name: emailField.text, password: passwordField.text)
        }
        
    }
    
    func showAlert(alertText : String, alertMessage : String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func addNewShowsToCoreData(data: LoginDataResponse) {
        
        let entity = NSEntityDescription.entity(forEntityName: "LoginHistoryResponse", in: DatabaseController.getContext())
        let newShow = NSManagedObject(entity: entity!, insertInto: DatabaseController.getContext())
        
        // Set the data to the entity
        newShow.setValue(data.ea == nil ? "shiva2@gmail.com": data.ea, forKey: "email")
        newShow.setValue(data.fn == nil ? "shiva2":data.fn, forKey: "firstName")
        newShow.setValue(data.ln == nil ? "test": data.ln, forKey: "lastName")
        newShow.setValue(Date(), forKey: "date")
        
    }
    
}

extension LoginViewController{
    func postDetails(name: String?, password: String?){
        var dict = [String: Any]()
        //{"COM": "Apple", "DN": "iPhone", "DOS":"iOS", "GCMUQID": "0", "MOD": "iPAd", "PWD":"123123", "UN":"shiva2", "Ver":"6.1"
    //}
        dict["COM"] = "Apple"
        dict["DN"] = "iPhone"
        dict["DOS"] = "iOS"
        dict["GCMUQID"] = "0"
        dict["MOD"] = "iPAd"
        dict["PWD"] = "123123"
        dict["UN"] = "shiva2"
        dict["Ver"] = "6.1"
        LoginViewModel.getDetails(parameters: dict, onResponse: {(result) in
            switch result{
            case .success(let data):
                self.resopnse = data
                self.addNewShowsToCoreData(data: data)
                DatabaseController.saveContext()
                DispatchQueue.main.async {
                    let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                    let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                    self.navigationController?.pushViewController(redViewController, animated: true)
                }
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        })
    }
}

