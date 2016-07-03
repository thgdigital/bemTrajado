//
//  SingleProdutoController.swift
//  bemTrajado
//
//  Created by Admin on 02/07/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit

class SingleProdutoController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    private let cellidHeader = "cellidHeader"
    private let cellId = "cellId"
    
    var produto: Produtos? {
        didSet {
            
            collectionView?.reloadData()
        }
        
    }
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         collectionView?.backgroundColor = UIColor.whiteColor()
        navigationItem.title = produto?.titulo
        collectionView?.registerClass(SingleCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.registerClass(HeaderSingleCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: cellidHeader)
        
       
        
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! SingleCell
        
    //  cell.produto = produto?[indexPath.item]
        
    cell.produto = produto
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 400)
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
         return CGSizeMake(view.frame.width, 240)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let header  = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: cellidHeader, forIndexPath: indexPath) as! HeaderSingleCell
        
        header.produto = produto
        
        return header
    }
    
}
