//
//  HomeHeaderCell.swift
//  bemTrajado
//
//  Created by Admin on 24/06/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit

class HomeHeaderCell: BaseCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "banner")
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        return iv
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addConstraintsWithFormat("H:|-8-[v0]-8-|", views: imageView)
        addConstraintsWithFormat("V:|-5-[v0]-5-|", views: imageView)
        
        
    }
    
    
}
