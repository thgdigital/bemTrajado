//
//  Categoria.swift
//  bemTrajado
//
//  Created by Admin on 25/06/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit

class Categoria: NSObject {
    
    var id : NSNumber?
    var titulo : String?
    var descricao: String?
    var image: String?
    var created_at: NSDate?
    var updated_at: NSDate?
    
    var produtos: [Produtos]?


    static func categoriasProdutos(completionHandler: ([Categoria]) -> ()) {
        
        let urlString = "http://thiago.conquist.com.br/api/categoria"
        
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: urlString)!) { (data, response, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            
            do {
                
                let json = try(NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers))
                var categorias = [Categoria]()
                
                
                for dictionary in json as! [[String: AnyObject]] {
                    
                    let categoria = Categoria()
                    
                    categoria.id = dictionary["id"] as? NSNumber
                    categoria.titulo = dictionary["titulo"] as? String
                    categoria.descricao = dictionary["descricao"] as? String
                    categoria.image = dictionary["image"] as? String
                    categoria.created_at = dictionary["created_at"] as? NSDate
                    categoria.created_at = dictionary["updated_at"] as? NSDate
                    categoria.produtos = [Produtos]()
                     let produtoDictionary = dictionary["produtos"] as! [[String: AnyObject]]
                    
                        
                        let produto = Produtos()
                    
                    
                        for prod in produtoDictionary {
                    
                            produto.id = prod["id"] as? NSNumber
                            produto.titulo = prod["titulo"] as? String
                            produto.descricao = prod["descricao"] as? String
                            produto.image = prod["image"] as? String
                            produto.preco = prod["preco"] as? String
                            produto.marca_id = prod["marca_id"] as? String
                            produto.qtd = prod["qtd"] as? String
                            produto.created_at = prod["created_at"] as? String
                            produto.updated_at = prod["updated_at"] as? String
            
                            categoria.produtos?.append(produto)
                            
                    }
                    if categoria.produtos?.count > 0 {
                        
                        categorias.append(categoria)
                    }
                }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    completionHandler(categorias)
                })
                
            } catch let err {
                print(err)
            }
            
            }.resume()
        
    }
 
}
