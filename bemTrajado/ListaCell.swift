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
    var left :NSLayoutAnchor<AnyObject>?
    var centerV :NSLayoutAnchor<AnyObject>?
    var produto: Produtos? {
        
        didSet {
            
            if let nome = produto?.titulo {
                nameLabel.text = nome
            }
            if let image = produto?.image{
                let url = "http://thiago.conquist.com.br/upload/"
                
                //roupaImageView.kf_setImageWithURL(URL(string: url+image))
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
        backgroundColor = UIColor.clear
       
        addSubview(nameLabel)
        addSubview(roupaImageView)
        addSubview(dividiView)
        addSubview(text)
        addSubview(namePreco)
        addConstraintsWithFormat("H:|-10-[v0]", views: nameLabel)
        addConstraintsWithFormat("H:|-10-[v0]-5-[v1(80)]-20-|", views: text,roupaImageView)
        addConstraintsWithFormat("H:|-10-[v0]|", views: namePreco)
        
        
        addConstraintsWithFormat("V:|-20-[v0(80)]", views: roupaImageView)
        addConstraintsWithFormat("V:|-20-[v0]", views: nameLabel)
        addConstraintsWithFormat("V:|-40-[v0]", views: text)
        addConstraintsWithFormat("V:|-100-[v0]", views: namePreco)
        
        
        addConstraintsWithFormat("H:|-10-[v0]-20-|", views: dividiView)
        addConstraintsWithFormat("V:[v0(3)]|", views: dividiView)
        
        
    }
    let roupaImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "blusa")
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 5
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
   
    let nameLabel : UILabel = {
        
        let categoria = UILabel()
        categoria.text = "Nome categoria"
        categoria.font = UIFont.systemFont(ofSize: 15)
        
        return categoria
    }()
    
    let text: UILabel = {
        let texto = UILabel()
        texto.text = "Ao contrário do que se acredita, Lorem Ipsum não é simplesmente um texto randômico."
        texto.font = UIFont.systemFont(ofSize: 14)
        texto.numberOfLines = 2
       
        
        return texto
    }()
    
    let namePreco: UILabel = {
        let label = UILabel()
        label.text = "R$ 190, 00"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let dividiView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(230, green: 32, blue: 31)
        
        return view
    }()
}
