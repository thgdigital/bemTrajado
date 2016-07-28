//
//  LoginController.swift
//  bemTrajado
//
//  Created by EntrevistaTeste on 27/07/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit
import Google

class LoginController: UIViewController {
    
    let contatinerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    let googleButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.backgroundColor = UIColor.rgb(211, green:  72, blue:  54)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 3
        
        return button
    }()
    
    func fecthProfile(user: User){
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
            print(token)
            //fecthProfile()
        }
        
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        
        if configureError != nil {
            print(configureError)
        }
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().language = "pt-PT"
        
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            //googleButton.hidden = true
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
extension LoginController: FBSDKLoginButtonDelegate, GIDSignInUIDelegate, GIDSignInDelegate{
    
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if error != nil{
            print(error)
            return
        }
        print(user.profile.email)
        print(user.profile.imageURLWithDimension(400))
        print(user.profile.familyName)
        print(user.profile.givenName)
        print(user.profile.name)
        
    }
    func signIn(signIn: GIDSignIn!, dismissViewController viewController: UIViewController!) {
       // self.dismissViewControllerAnimated(true, completion: nil)
    }
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if error != nil{
            print(error)
            return
        }
        print(result)
        //fecthProfile()
    }
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
}
