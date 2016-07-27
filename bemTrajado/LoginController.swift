//
//  LoginController.swift
//  bemTrajado
//
//  Created by EntrevistaTeste on 27/07/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit

class LoginController: UIViewController, FBSDKLoginButtonDelegate {
    
    let contatinerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = UIColor.whiteColor()
        view.layer.cornerRadius = 10
        return view
    }()
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "logo")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 10
        iv.contentMode = .ScaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    let facebookButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let googleButton: UIButton = {
        let button = UIButton(type: .System)
        button.backgroundColor = UIColor.rgb(211, green:  72, blue:  54)
        
        button.setTitle("Login com Google", forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        button.layer.cornerRadius = 3
        return button
    }()
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        fecthProfile()
    }
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
     return true
    }
    func fecthProfile(){
        print("dados do perfil")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(235, green: 76, blue: 76)
        facebookButton.delegate = self
        view.addSubview(contatinerView)
        view.addSubview(logoImageView)
        contatinerView.addSubview(facebookButton)
        contatinerView.addSubview(googleButton)
        
        if let token = FBSDKAccessToken.currentAccessToken() {
            fecthProfile()
        }
        
        
        //x,y,w,h
        contatinerView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        contatinerView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        contatinerView.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -24).active = true
        contatinerView.heightAnchor.constraintEqualToConstant(150).active = true
        
        //x,y,w,h
        facebookButton.topAnchor.constraintEqualToAnchor(contatinerView.topAnchor).active = true
        facebookButton.leftAnchor.constraintEqualToAnchor(contatinerView.leftAnchor).active = true
        facebookButton.widthAnchor.constraintEqualToAnchor(contatinerView.widthAnchor).active = true
        facebookButton.heightAnchor.constraintEqualToConstant(50).active = true
        
        //x,y,w,h
        googleButton.topAnchor.constraintEqualToAnchor(facebookButton.bottomAnchor, constant: 5).active = true
        googleButton.leftAnchor.constraintEqualToAnchor(contatinerView.leftAnchor).active = true
        googleButton.widthAnchor.constraintEqualToAnchor(contatinerView.widthAnchor).active = true
        googleButton.heightAnchor.constraintEqualToConstant(50).active = true
        
        //x,y,w,h
        logoImageView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        logoImageView.bottomAnchor.constraintEqualToAnchor(contatinerView.topAnchor, constant: -12).active = true
        logoImageView.widthAnchor.constraintEqualToConstant(150).active = true
        logoImageView.heightAnchor.constraintEqualToConstant(150).active = true
        
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
