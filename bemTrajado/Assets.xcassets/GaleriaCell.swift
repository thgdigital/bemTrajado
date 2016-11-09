//
//  GaleriaCell.swift
//  bemTrajado
//
//  Created by Admin on 02/07/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit
import Kingfisher


class GalerialCell: BaseCell {
    var singleController: SingleProdutoController?
    
    var galeria: Galeria? {
        didSet {
            if let image = galeria?.image {
                
                let url = "http://thiago.conquist.com.br/upload/"
                
                //imageView.kf_setImageWithURL(NSURL(string: url+image))
               // imageView.loadImageWithUrl(url+image, placeholder: UIImage(named: "placeholder"))
            }
        }
    }
    
    let imageView: CustomImageView = {
        let iv = CustomImageView()
        iv.image = UIImage(named: "blusa")
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(imageView)
        addConstraintsWithFormat("H:|[v0]|", views: imageView)
        addConstraintsWithFormat("H:|[v0]|", views: imageView)
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))
        
    }
    func animate() {
      
        singleController?.animateImageView(imageView)
    }
}
