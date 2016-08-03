//
//  ConfigController.swift
//  bemTrajado
//
//  Created by EntrevistaTeste on 03/08/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit

class ConfigController: UIViewController {
    var login = FBSDKLoginManager()
    

    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        navigationItem.title = "CONFIGURAÇÕES"
        view.backgroundColor = UIColor.whiteColor()
      
        navigationItem.rightBarButtonItem =  UIBarButtonItem(title: "Sair", style: .Plain, target: self, action: #selector(addTapped))
        // Do any additional setup after loading the view.
    }
    func addTapped(){
        login.logOut()
        GIDSignIn.sharedInstance().signOut()
        if let _ = FBSDKAccessToken.currentAccessToken() {
           
        }else if  GIDSignIn.sharedInstance().hasAuthInKeychain() {
            
        }else{
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = LoginController()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}