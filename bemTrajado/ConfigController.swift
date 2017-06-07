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
import VMaskTextField



class ConfigController: UITableViewController, UITextFieldDelegate {
    var login = FBSDKLoginManager()
    
    @IBOutlet weak var avatarImageView: UIImageView!

    @IBOutlet weak var nomeTextField: UITextField!
   // @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var telefoneTextField: VMaskTextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        telefoneTextField.mask = "(##) ####-#####"
        nomeTextField.delegate = self
//        emailTextField.delegate = self
        telefoneTextField.delegate = self
     
       
        
        
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return telefoneTextField.shouldChangeCharacters(in: range, replacementString: string)
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
//        emailTextField.resignFirstResponder()
        telefoneTextField.resignFirstResponder()
        guard let  nome = nomeTextField.text, let telefone = telefoneTextField.text else {
            print("Form is not valid")
        
            return
        }
        
        self.view.showActivityView(withLabel: "Salvando dados..")
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            self.view.hideActivityView()
            return
        }
        
        let usersReference = App.ref.child("users").child(uid)
        let values = ["name": nome, "telefone": telefone]
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print(err)
                return
            }
            self.view.hideActivityView()
           
        })
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
   
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
}
