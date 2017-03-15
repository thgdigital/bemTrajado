//
//  ProdutoHome.swift
//  bemTrajado
//
//  Created by Admin on 24/06/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit


class ProdutoHomeCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
  
    
    fileprivate let cellId = "cellId"
    
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
        layout.scrollDirection = .horizontal
        let colletion  = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colletion.translatesAutoresizingMaskIntoConstraints = false
        colletion.backgroundColor = UIColor.white
        
        return colletion
    }()
    let nameLabel : UILabel = {
        
        let categoria = UILabel()
        categoria.text = "Nome categoria"
        categoria.font = UIFont.systemFont(ofSize: 15)
        
        return categoria
    }()
    
//    let dividiView : UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
//        
//        return view
//    }()
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProdutoHomeMinCell
        cell.produtos = categoria?.produtos?[(indexPath as NSIndexPath).item]
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count = categoria?.produtos?.count {
            
            return count
        }
         
        
        return 0
       
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: frame.height - 25)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 14, 0, 14)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let app = categoria?.produtos?[(indexPath as NSIndexPath).item]{
            
            if let id = app.id {
                var produto = Produtos()
                Produtos.getProduto(id) { (Produtos) in
                    produto = Produtos
                      self.homeController?.showAppDetailForApp(produto)
                }
               
            }
            
          
           // print(app)
          
        }
    }
    override func setupViews() {
        super.setupViews()
        
        addSubview(collectionView)
//        addSubview(dividiView)
        addSubview(nameLabel)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        collectionView.register(ProdutoHomeMinCell.self, forCellWithReuseIdentifier: cellId)

        
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|-24-[v0]|", views:  collectionView)
        
        addConstraintsWithFormat("H:|-14-[v0]", views: nameLabel)
        addConstraintsWithFormat("V:|-4-[v0]", views: nameLabel)
        
//        addConstraintsWithFormat("H:|[v0]|", views: dividiView)
//        addConstraintsWithFormat("V:[v0(1)]|", views: dividiView)
    }
    
}
