//
//  ConfigController.swift
//  bemTrajado
//
//  Created by EntrevistaTeste on 03/08/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import RNActivityView


class ConfigController: UITableViewController, UITextFieldDelegate {
    var login = FBSDKLoginManager()
    
    @IBOutlet weak var avatarImageView: UIImageView!

    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var telefoneTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        
        nomeTextField.delegate = self
        emailTextField.delegate = self
        telefoneTextField.delegate = self
     
       
        
        super.viewDidLoad()
        navigationItem.title = "CONFIGURAÇÕES"
        view.backgroundColor = UIColor.white
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        avatarImageView.layer.masksToBounds = true
       
        self.tableView.tableFooterView = UIView()
        tableView.delegate = self
        navigationItem.rightBarButtonItem =  UIBarButtonItem(title: "Sair", style: .plain, target: self, action: #selector(addTapped))
        // Do any additional setup after loading the view.
      listUser()
    }
    func addTapped(){
        login.logOut()
        GIDSignIn.sharedInstance().signOut()
        
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }

    private func listUser(){
        self.view.showActivityView(withLabel: "Carregando..")
        let userID = FIRAuth.auth()?.currentUser?.uid
          App.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            if let name = value?["name"] as? String{
                
                self.nomeTextField?.text = name
            }
            if let email = value?["email"] as? String{
                
                self.emailTextField?.text = email
            }
            if let telefone = value?["telefone"] as? String{
                
                self.telefoneTextField?.text = telefone
            }
            self.view.hideActivityView()
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    @IBAction func salvarAlteracao(_ sender: Any) {
        nomeTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        telefoneTextField.resignFirstResponder()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        nomeTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        telefoneTextField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
}
