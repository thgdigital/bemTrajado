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
    
    
    static func cadUser(_ user: User, completionHandler: @escaping (User) -> ()){
    let urlString = "http://thiago.conquist.com.br/api/user/login-rede-social"
      let parameters = ["email": user.email!, "name": user.name!, "avatar": user.avatar!, "password": "bemtrajado"]
        print(parameters)
        Alamofire.request(urlString, method: .post, parameters: parameters)
            .validate()
            .responseJSON { response in
               
                let users = User()
                switch response.result {
                case .success:
                    
                    if let jsonObject = response.result.value {
                        let json = JSON(jsonObject)
                        
                        users.id = json["id"].number
                        users.email = json["email"].stringValue
                        users.avatar = json["avatar"].stringValue
                        users.name = json["name"].stringValue
                        
                    }
                    
                    
                    let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(0.1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                    DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
                        
                        completionHandler(users)
                    })
                case .failure(let error):
                    print("===========================")
                        print(error)
                    print("===========================")
                }
                
        }
    }
    
   override init() {
        super.init()
    }
    required init?(coder decoder: NSCoder) {
        self.id = decoder.decodeObject(forKey: "id") as? NSNumber
        self.name = decoder.decodeObject(forKey: "name") as? String
        self.email = decoder.decodeObject(forKey: "email") as? String
        self.avatar = decoder.decodeObject(forKey: "avatar") as? String
        
        super.init()
    }
    func encode(with encoder: NSCoder) {
        encoder.encode(self.id, forKey: "id")
        encoder.encode(self.name, forKey: "name")
        encoder.encode(self.avatar, forKey: "avatar")
        encoder.encode(self.email, forKey: "email")
    }

}
