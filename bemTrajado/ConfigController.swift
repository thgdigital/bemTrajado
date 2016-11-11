//
//  ConfigController.swift
//  bemTrajado
//
//  Created by EntrevistaTeste on 03/08/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit
import FBSDKLoginKit

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
        if let _ = FBSDKAccessToken.current() {
           
        }else if  GIDSignIn.sharedInstance().hasAuthInKeychain() {
            
        }else{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = LoginController()
            
        }
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
