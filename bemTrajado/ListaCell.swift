//
//  ListaCell.swift
//  bemTrajado
//
//  Created by EntrevistaTeste on 26/07/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit
import Kingfisher

class ListaCell: BaseCell {
    var left :NSLayoutAnchor?
    var centerV :NSLayoutAnchor?
    var produto: Produtos? {
        
        didSet {
            
            if let nome = produto?.titulo {
                nameLabel.text = nome
            }
            if let image = produto?.image{
                let url = "http://thiago.conquist.com.br/upload/"
                
                roupaImageView.kf_setImageWithURL(NSURL(string: url+image))
            }
            if let descri = produto?.descricao {
                print(descri)
                text.text = descri
            }
            if let preco = produto?.preco {
                
                namePreco.text = "R$ \(preco)"
            }
            
        }
        
    }

    override func setupViews() {
        backgroundColor = UIColor.clearColor()
       
        addSubview(nameLabel)
        addSubview(roupaImageView)
        addSubview(dividiView)
        addSubview(text)
        addSubview(namePreco)
        addConstraintsWithFormat("H:|-20-[v0(140)]", views: roupaImageView)
        addConstraintsWithFormat("H:|-180-[v0]", views: nameLabel)
        addConstraintsWithFormat("H:|-180-[v0]-20-|", views: text)
        addConstraintsWithFormat("H:|-180-[v0]|", views: namePreco)
        
        
        addConstraintsWithFormat("V:|-20-[v0(140)]", views: roupaImageView)
        addConstraintsWithFormat("V:|-20-[v0]", views: nameLabel)
        addConstraintsWithFormat("V:|-40-[v0]", views: text)
        addConstraintsWithFormat("V:|-100-[v0]", views: namePreco)
        
        
        addConstraintsWithFormat("H:|[v0]|", views: dividiView)
        addConstraintsWithFormat("V:[v0(1)]|", views: dividiView)
        
        
    }
    let roupaImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "blusa")
        iv.contentMode = .ScaleAspectFill
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 5
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
   
    let nameLabel : UILabel = {
        
        let categoria = UILabel()
        categoria.text = "Nome categoria"
        categoria.font = UIFont.systemFontOfSize(15)
        
        return categoria
    }()
    
    let text: UILabel = {
        let texto = UILabel()
        texto.text = "Ao contrário do que se acredita, Lorem Ipsum não é simplesmente um texto randômico."
        texto.font = UIFont.systemFontOfSize(14)
        texto.numberOfLines = 3
        texto.adjustsFontSizeToFitWidth = true
        
        return texto
    }()
    
    let namePreco: UILabel = {
        let label = UILabel()
        label.text = "R$ 190, 00"
        label.font = UIFont.boldSystemFontOfSize(12)
        
        
        return label
    }()
    
    let dividiView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        
        return view
    }()
}
