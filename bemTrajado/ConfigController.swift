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

class ConfigController: UITableViewController {
    var login = FBSDKLoginManager()
    

    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        navigationItem.title = "CONFIGURAÇÕES"
        view.backgroundColor = UIColor.white
      
        navigationItem.rightBarButtonItem =  UIBarButtonItem(title: "Sair", style: .plain, target: self, action: #selector(addTapped))
        // Do any additional setup after loading the view.
      
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
//     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return UITableViewCell()
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    }

}
