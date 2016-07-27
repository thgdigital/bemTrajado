//
//  ListaCell.swift
//  bemTrajado
//
//  Created by EntrevistaTeste on 26/07/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit

class ListaCell: BaseCell {
    
    
    override func setupViews() {
        backgroundColor = UIColor.redColor()
        print("fui chamdo")
        addSubview(nameLabel)
        addConstraintsWithFormat("H:|[v0]|", views: nameLabel)
        addConstraintsWithFormat("V:|[v0]", views: nameLabel)
    }
    
    let nameLabel : UILabel = {
        
        let categoria = UILabel()
        categoria.text = "Nome categoria"
        categoria.font = UIFont.systemFontOfSize(15)
        
        return categoria
    }()
}
