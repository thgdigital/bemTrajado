//
//  HeaderSingleCell.swift
//  bemTrajado
//
//  Created by Admin on 02/07/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit

class HeaderSingleCell: BaseCell {
    
    var singleController : SingleProdutoController?
    
    var produto: Produtos? {
        didSet {
            if let image = produto?.image {
                
               
               imageView.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "bemTrajado"))
            
            }
            
        }
        
    }
    
    let imageView: CustomImageView = {
        let iv = CustomImageView()
        iv.image = UIImage(named: "banner")
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    
    let dividiView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        
        return view
    }()
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addSubview(dividiView)
       
        addConstraintsWithFormat("H:|-8-[v0]-8-|", views: imageView)
        
        addConstraintsWithFormat("V:|-5-[v0]-5-|", views: imageView)
        
        addConstraintsWithFormat("H:|[v0]|", views: dividiView)
        addConstraintsWithFormat("V:[v0(1)]|", views: dividiView)
        
        
        //imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))
        
    }
//    
//    func animate() {
//        
//        singleController?.animateImageView(imageView)
//    }
    
    
}
