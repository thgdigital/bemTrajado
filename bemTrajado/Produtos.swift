//
//  Produtos.swift
//  bemTrajado
//
//  Created by Admin on 25/06/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class Produtos: NSObject {
    var id : NSNumber?
    var titulo: String?
    var descricao : String?
    var image: String?
    var preco: String?
    var marca_id: String?
    var qtd: String?
    var created_at: String?
    var updated_at: String?
    var galeria: [Galeria]?
    
    
    static func getProduto(id: NSNumber, completionHandler: (Produtos) -> ()) {
        let urlString = "http://thiago.conquist.com.br/api/produtos/\(id)/ver"
        Alamofire.request(.GET, urlString)
            .validate()
            .responseJSON { response in
                
                let produto = Produtos()
                switch response.result {
                case .Success:
                 
                        if let jsonObject = response.result.value {
                            let json = JSON(jsonObject)
                            produto.id = json["id"].number
                            produto.titulo = json["titulo"].stringValue
                            produto.descricao = json["descricao"].stringValue
                            produto.image = json["image"].stringValue
                            produto.preco = json["preco"].stringValue
                            produto.marca_id = json["marca_id"].stringValue
                            produto.qtd = json["qtd"].stringValue
                            produto.created_at = json["created_at"].stringValue
                            produto.updated_at = json["updated_at"].stringValue
                            produto.galeria = [Galeria]()
                            
                            for (_, subJson):(String, JSON) in json["galerias"] {
                                let galeria = Galeria()
                                galeria.id = subJson["id"].number
                                galeria.image = subJson["image"].stringValue
                                galeria.created_at = subJson["created_at"].stringValue
                                galeria.updated_at = subJson["updated_at"].stringValue
                                produto.galeria?.append(galeria)
                            }
                            
                        }
                    
                   
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                           
                            completionHandler(produto)
                        })
                case .Failure(let error):
                    print(error)
                }
                
        }
    }
}
