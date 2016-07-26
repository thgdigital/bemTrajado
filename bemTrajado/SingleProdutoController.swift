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
     let zoomImageView = UIImageView()
    let blackBackgroungView = UIView()
    var imageView: UIImageView?
    let navBarBack = UIView()
    let tabBarBack = UIView()
    
    
    
    func animateImageView(imageView: UIImageView){
        self.imageView = imageView
        if let position =  imageView.superview?.convertRect(imageView.frame, toView: nil){
            navBarBack.frame = CGRectMake(0, 0, 1000, 20 + 44)
            navBarBack.backgroundColor = UIColor.blackColor()
            navBarBack.alpha = 0
            if let keyWindows = UIApplication.sharedApplication().keyWindow{
                keyWindows.addSubview(navBarBack)
                tabBarBack.frame = CGRectMake(0, keyWindows.frame.height - 49, 1000, 49)
                tabBarBack.backgroundColor = UIColor.blackColor()
                tabBarBack.alpha = 0
                keyWindows.addSubview(tabBarBack)
                
            }
            
            imageView.alpha = 0
            blackBackgroungView.frame = self.view.frame
            blackBackgroungView.backgroundColor = UIColor.blackColor()
            blackBackgroungView.alpha = 0
            view.addSubview(blackBackgroungView)
            zoomImageView.backgroundColor = UIColor.redColor()
            zoomImageView.userInteractionEnabled = true
            zoomImageView.image = imageView.image
            zoomImageView.frame = position
            zoomImageView.contentMode = .ScaleAspectFill
            zoomImageView.clipsToBounds = true
            view.addSubview(zoomImageView)
            zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOut)))
            
            UIView.animateWithDuration(0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .CurveEaseOut, animations: {
                    let height  = self.view.frame.width / position.width * position.height / 6
                    let y = self.view.frame.height / 2 -  height / 2
                    self.zoomImageView.frame = CGRectMake(0, y, self.view.frame.width, height)
                    self.blackBackgroungView.alpha = 1
                    self.navBarBack.alpha = 1
                    self.tabBarBack.alpha = 1
                
                }, completion: nil)
            
        }
        
    
    }
    func zoomOut() {
        
        if let position = imageView!.superview?.convertRect(imageView!.frame, toView: nil){
            UIView.animateWithDuration(0.75, animations: {
                
            })
        UIView.animateWithDuration(0.75, animations: {
            self.zoomImageView.frame = position
            self.blackBackgroungView.alpha = 0
            self.navBarBack.alpha = 0
            self.tabBarBack.alpha = 0
            }, completion: { (didComplete) in
                
                self.zoomImageView.removeFromSuperview()
                self.blackBackgroungView.removeFromSuperview()
                self.navBarBack.removeFromSuperview()
                self.tabBarBack.removeFromSuperview()
                self.imageView?.alpha = 1
        })
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
        
        
        cell.produto = produto
        cell.singleController = self
        
        
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
        header.singleController = self
        return header
    }
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}
