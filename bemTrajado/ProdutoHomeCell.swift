//
//  ProdutoHome.swift
//  bemTrajado
//
//  Created by Admin on 24/06/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit


class ProdutoHomeCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
  
    
    private let cellId = "cellId"
    
    var homeController : HomeController?
    
    var categoria: Categoria? {
        
        didSet {
            
            if let nome = categoria?.titulo {
                 nameLabel.text = nome
            }
            collectionView.reloadData()
        }
        
    }
    
   
    
    
    
    let collectionView : UICollectionView = {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        let colletion  = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colletion.translatesAutoresizingMaskIntoConstraints = false
        colletion.backgroundColor = UIColor.whiteColor()
        
        return colletion
    }()
    let nameLabel : UILabel = {
        
        let categoria = UILabel()
        categoria.text = "Nome categoria"
        categoria.font = UIFont.systemFontOfSize(15)
        
        return categoria
    }()
    
    let dividiView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        
        return view
    }()
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! ProdutoHomeMinCell
        cell.produtos = categoria?.produtos?[indexPath.item]
        
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count = categoria?.produtos?.count {
            
            return count
        }
         
        
        return 0
       
    }
   
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(200, frame.height - 25)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 14, 0, 14)
        
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let app = categoria?.produtos?[indexPath.item]{
          
           // print(app)
            homeController?.showAppDetailForApp(app)
        }
    }
    override func setupViews() {
        super.setupViews()
        
        addSubview(collectionView)
        addSubview(dividiView)
        addSubview(nameLabel)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        collectionView.registerClass(ProdutoHomeMinCell.self, forCellWithReuseIdentifier: cellId)

        
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|-24-[v0]|", views:  collectionView)
        
        addConstraintsWithFormat("H:|-14-[v0]", views: nameLabel)
        addConstraintsWithFormat("V:|-4-[v0]", views: nameLabel)
        
        addConstraintsWithFormat("H:|[v0]|", views: dividiView)
        addConstraintsWithFormat("V:[v0(1)]|", views: dividiView)
    }
    
}