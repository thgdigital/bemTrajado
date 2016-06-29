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
    var created_at: String?
    var updated_at: String?
    
    var produtos: [Produtos]?
    
    static func categoriasProdutos(completionHandler: (Categoria) -> ()) {
        
        let urlString = "http://thiago.conquist.com.br/api/categoria"
        
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: urlString)!) { (data, response, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            
            do {
                
                let json = try(NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers))
                
                let categorias = Categoria()
                
                categorias.setValuesForKeysWithDictionary(json as! [String : AnyObject])
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    completionHandler(categorias)
                })
                
            } catch let err {
                print(err)
            }
            
            }.resume()
        
    }
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "produtos" {
            produtos = [Produtos]()
            for dict in value as! [[String: AnyObject]] {
                let produto = Produtos()
                produto.setValuesForKeysWithDictionary(dict)
                produtos?.append(produto)
                
            }
        }else{
            super.setValue(value, forKey: key)
        }
    }
}
