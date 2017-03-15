//
//  Categoria.swift
//  bemTrajado
//
//  Created by Admin on 25/06/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class Categoria: NSObject {
    
    var id : NSNumber?
    var titulo : String?
    var descricao: String?
    var image: String?
    var created_at: String?
    var updated_at: String?
    
    var produtos: [Produtos]?


    static func categoriasProdutos(_ completionHandler: @escaping ([Categoria] )  -> ()) {
        
        let urlString = "http://private-72625-api389.apiary-mock.com/categorias"
        
        Alamofire.request(urlString)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    if response.result.value is NSArray {
                        
                        if let jsonObject = response.result.value {
                            let json = JSON(jsonObject)
                            var categorias = [Categoria]()
                        
                            for (_, subJson):(String, JSON) in json {
                                let categoria = Categoria()
                                categoria.id = subJson["id"].number
                                categoria.titulo = subJson["titulo"].stringValue
                                categoria.descricao = subJson["descricao"].stringValue
                                categoria.image = subJson["image"].stringValue
                                categoria.created_at = subJson["created_at"].stringValue
                                categoria.created_at = subJson["updated_at"].stringValue
                                categoria.produtos = [Produtos]()
                                let produtoDictionary = subJson["produtos"].arrayValue
                                
                                for prod in produtoDictionary {
                                    let produto = Produtos()
                                    produto.id = prod["id"].number
                                    
                                    produto.titulo = prod["titulo"].stringValue
                                    produto.descricao = prod["descricao"].stringValue
                                    produto.image = prod["image"].stringValue
                                    produto.preco = prod["preco"].stringValue
                                    produto.marca_id = prod["marca_id"].stringValue
                                    produto.qtd = prod["qtd"].stringValue
                                    produto.created_at = prod["created_at"].stringValue
                                    produto.updated_at = prod["updated_at"].stringValue
                                            
                                    categoria.produtos?.append(produto)
                                    
                                    }
                                    if (categoria.produtos?.count)! > 0 {
                                        categorias.append(categoria)
                                    }
                                }
                            let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(0.1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                            DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
                                    completionHandler(categorias)
                                })
                            }
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
}
