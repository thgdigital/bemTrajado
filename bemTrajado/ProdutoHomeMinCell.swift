//
//  ProdutoHomeMinCell.swift
//  bemTrajado
//
//  Created by Admin on 24/06/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit
import Kingfisher
import SDWebImage

class ProdutoHomeMinCell: BaseCell {
    
     
  
    var produtos: Produtos?{
        didSet {
            if let nome = produtos?.titulo {
                nameLabel.text = nome
            }
            if let preco = produtos?.preco {
                namePreco.text = "R$ \(preco)"
            }
            if let image = produtos?.image {
               imageView.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "bemTrajado"))
               
            }
        }
        
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(namePreco)
        addConstraintsWithFormat("H:|[v0]|", views: imageView)
        addConstraintsWithFormat("H:|[v0]|", views: nameLabel)
        addConstraintsWithFormat("H:|[v0]", views: namePreco)
        //addConstraintsWithFormat("V:|-14-[v0(30)]", views: namePreco),
        addConstraintsWithFormat("V:|[v0(150)][v1][v2]-15-|", views: imageView, nameLabel, namePreco )
        
    }
    
    let imageView : CustomImageView = {
        
        let iv = CustomImageView()
        iv.image = UIImage(named: "bemTrajado")
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 5
        return iv
    }()
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Blusa da lacoste"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    let namePreco: UILabel = {
        let label = UILabel()
        label.text = "R$ 190, 00"
        label.font = UIFont.boldSystemFont(ofSize: 12)
  
        
        return label
    }()
    
    
}
