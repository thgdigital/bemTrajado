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
        button.readPermissions = ["public_profile", "email","user_friends",]
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
        
        print(user)
     
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(235, green: 76, blue: 76)
        facebookButton.delegate = self
        view.addSubview(contatinerView)
        view.addSubview(logoImageView)
        contatinerView.addSubview(facebookButton)
        contatinerView.addSubview(googleButton)
       
        
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
        
        let users = User()
        users.email = user.profile.email
        users.name = user.profile.familyName
        users.avatar = user.profile.imageURLWithDimension(400).absoluteString
        fecthProfile(users)
        
        
    }
    func signIn(signIn: GIDSignIn!, dismissViewController viewController: UIViewController!) {
       // self.dismissViewControllerAnimated(true, completion: nil)
    }
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if error != nil{
            print(error)
            return
        }
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler({ (connection, user, requestError) -> Void in
            
            if requestError != nil {
                print(requestError)
                return
            }
            
            let email = user["email"] as? String
            let firstName = user["first_name"] as? String
            let lastName = user["last_name"] as? String
            
            
            let users = User()
            users.email = email
            users.name = "\(firstName!) \(lastName!)"
            
            var pictureUrl = ""
            
            if let picture = user["picture"] as? NSDictionary, data = picture["data"] as? NSDictionary, url = data["url"] as? String {
                pictureUrl = url
            }
            users.avatar = pictureUrl
            
            self.fecthProfile(users)
        })
    }
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        print(loginButton)
        return true
    }
    
}
