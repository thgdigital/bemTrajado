//
//  User.swift
//  bemTrajado
//
//  Created by EntrevistaTeste on 28/07/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class User: NSObject, NSCoding {
    var id: NSNumber?
    var name: String?
    var email: String?
    var avatar:String?
    
    
    static func cadUser(user: User, completionHandler: (User) -> ()){
    let urlString = "http://thiago.conquist.com.br/api/user/login-rede-social"
      let parameters = ["email": user.email!, "name": user.name!, "avatar": user.avatar!, "password": "bemtrajado"]
        
        Alamofire.request(.POST, urlString, parameters: parameters)
            .validate()
            .responseJSON { response in
               
                let users = User()
                switch response.result {
                case .Success:
                    
                    if let jsonObject = response.result.value {
                        let json = JSON(jsonObject)
                        
                        users.id = json["id"].number
                        users.email = json["email"].stringValue
                        users.avatar = json["avatar"].stringValue
                        users.name = json["name"].stringValue
                        
                    }
                    
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        completionHandler(users)
                    })
                case .Failure(let error):
                    print(error)
                }
                
        }
    }
    
   override init() {
        super.init()
    }
    required init?(coder decoder: NSCoder) {
        self.id = decoder.decodeObjectForKey("id") as? NSNumber
        self.name = decoder.decodeObjectForKey("name") as? String
        self.email = decoder.decodeObjectForKey("email") as? String
        self.avatar = decoder.decodeObjectForKey("avatar") as? String
        
        super.init()
    }
    func encodeWithCoder(encoder: NSCoder) {
        encoder.encodeObject(self.id, forKey: "id")
        encoder.encodeObject(self.name, forKey: "name")
        encoder.encodeObject(self.avatar, forKey: "avatar")
        encoder.encodeObject(self.email, forKey: "email")
    }

}
