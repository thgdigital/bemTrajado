//
//  BaseCell.swift
//  bemTrajado
//
//  Created by Admin on 24/06/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit


class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
}