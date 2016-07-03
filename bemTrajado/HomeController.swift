//
//  ViewController.swift
//  bemTrajado
//
//  Created by Admin on 24/06/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    
    private let cellId = "cellId"
    private let cellHeaderId = "cellHeaderId"
    var categorias :  [Categoria]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.whiteColor()
        navigationItem.title = "Bem Trajados Multimarcas"
        
    
        
        let titleLabel = UILabel(frame: CGRectMake(0, 0, view.frame.width - 32, view.frame.height))
        titleLabel.text = "Bem Trajados Multimarcas"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.systemFontOfSize(20)
        navigationItem.titleView = titleLabel
        
        Categoria.categoriasProdutos { (categoria) in

            self.categorias = categoria
            self.collectionView?.reloadData()
        }
        
       
        
        
        
        collectionView?.registerClass(ProdutoHomeCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.registerClass(HomeHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: cellHeaderId)
        
    }
    
    func showAppDetailForApp(produto: Produtos) {
        let layout = UICollectionViewFlowLayout()
        let singleProdutoController = SingleProdutoController(collectionViewLayout: layout)
        singleProdutoController.produto = produto
        navigationController?.pushViewController(singleProdutoController, animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
         return CGSizeMake(view.frame.width, 200)
    }
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: cellHeaderId, forIndexPath: indexPath)
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let cout = categorias?.count {
            return cout
        }
        return 0
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
         let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! ProdutoHomeCell
        
        cell.categoria = categorias?[indexPath.item]
        cell.homeController = self
        return cell
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 240)
    }


    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    


}





