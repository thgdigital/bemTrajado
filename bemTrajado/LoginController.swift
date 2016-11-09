//
//  LoginController.swift
//  bemTrajado
//
//  Created by EntrevistaTeste on 27/07/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit
import Google
import FBSDKLoginKit

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
        iv.contentMode = .scaleAspectFill
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
    
    func fecthProfile(_ user: User){
     User.cadUser(user) { (User) in
        let defaults = UserDefaults.standard
        defaults.set(NSKeyedArchiver.archivedData(withRootObject: User), forKey: "user")
       
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = TabCustomController()

        }
     
        
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
        contatinerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contatinerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        contatinerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        contatinerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        //x,y,w,h
        facebookButton.topAnchor.constraint(equalTo: contatinerView.topAnchor).isActive = true
        facebookButton.leftAnchor.constraint(equalTo: contatinerView.leftAnchor).isActive = true
        facebookButton.widthAnchor.constraint(equalTo: contatinerView.widthAnchor).isActive = true
        facebookButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //x,y,w,h
        googleButton.topAnchor.constraint(equalTo: facebookButton.bottomAnchor, constant: 5).isActive = true
        googleButton.leftAnchor.constraint(equalTo: contatinerView.leftAnchor).isActive = true
        googleButton.widthAnchor.constraint(equalTo: contatinerView.widthAnchor).isActive = true
        googleButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //x,y,w,h
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.bottomAnchor.constraint(equalTo: contatinerView.topAnchor, constant: -12).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}
extension LoginController: FBSDKLoginButtonDelegate, GIDSignInUIDelegate, GIDSignInDelegate{
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
    }

    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: NSError!) {
        if error != nil{
            print(error)
            return
        }
        
        let users = User()
        users.email = user.profile.email
        users.name = user.profile.familyName
        users.avatar = user.profile.imageURL(withDimension: 400).absoluteString
        fecthProfile(users)
        
        
    }
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
       // self.dismissViewControllerAnimated(true, completion: nil)
    }
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil{
            print(error)
            return
        }
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(completionHandler: { (connection, user, requestError) -> Void in
            
            if requestError != nil {
                //print(requestError)
                return
            }
            if let dataDict = user as? [String:AnyObject] {
            let email = dataDict["email"] as? String
            let firstName = dataDict["first_name"] as? String
            let lastName = dataDict["last_name"] as? String
            
            
            let users = User()
            users.email = email
            users.name = "\(firstName!) \(lastName!)"
            
            var pictureUrl = ""
            
            if let picture = dataDict["picture"] as? NSDictionary, let data = picture["data"] as? NSDictionary, let url = data["url"] as? String {
                pictureUrl = url
            }
            users.avatar = pictureUrl
            
            self.fecthProfile(users)
               
              
            }
        })
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        
        return true
    }
    
}
