//
//  DesejoCell.swift
//  bemTrajado
//
//  Created by Thiago Santos on 09/11/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit

class DesejoCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subDescription: UILabel!
    @IBOutlet weak var precoLabel: UILabel!
    @IBOutlet weak var roupaImageView: UIImageView!
    var produto: Produtos? {
        
        didSet {
            
            
//            if let preco = produto?.preco {
//                
//                namePreco.text = "R$ \(preco)"
//            }
            
        }
        
    }
    func layoutCell(_ produto: Produtos?) {
        roupaImageView?.contentMode = .scaleAspectFill
        roupaImageView?.layer.masksToBounds = true
        roupaImageView?.layer.cornerRadius = 5
        
        
        if let nome = produto?.titulo {
            titleLabel.text = nome
        }
//        if let image = produto?.image{
//            let url = "http://thiago.conquist.com.br/upload/"
//            
//            //roupaImageView.kf_setImageWithURL(URL(string: url+image))
//        }
        if let descri = produto?.descricao {
           
            subDescription.text = descri
        }
        if let preco = produto?.preco{
            precoLabel?.text = "R$ \(preco)"
        }
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
