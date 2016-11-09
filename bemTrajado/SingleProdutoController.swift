//
//  SingleProdutoController.swift
//  bemTrajado
//
//  Created by Admin on 02/07/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit

class SingleProdutoController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    fileprivate let cellidHeader = "cellidHeader"
    fileprivate let cellId = "cellId"
    
    
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
    
    
    
    func animateImageView(_ imageView: UIImageView){
        self.imageView = imageView
        if let position =  imageView.superview?.convert(imageView.frame, to: nil){
            navBarBack.frame = CGRect(x: 0, y: 0, width: 1000, height: 20 + 44)
            navBarBack.backgroundColor = UIColor.black
            navBarBack.alpha = 0
            if let keyWindows = UIApplication.shared.keyWindow{
                keyWindows.addSubview(navBarBack)
                tabBarBack.frame = CGRect(x: 0, y: keyWindows.frame.height - 49, width: 1000, height: 49)
                tabBarBack.backgroundColor = UIColor.black
                tabBarBack.alpha = 0
                keyWindows.addSubview(tabBarBack)
                
            }
            
            imageView.alpha = 0
            blackBackgroungView.frame = self.view.frame
            blackBackgroungView.backgroundColor = UIColor.black
            blackBackgroungView.alpha = 0
            view.addSubview(blackBackgroungView)
            zoomImageView.backgroundColor = UIColor.red
            zoomImageView.isUserInteractionEnabled = true
            zoomImageView.image = imageView.image
            zoomImageView.frame = position
            zoomImageView.contentMode = .scaleAspectFill
            zoomImageView.clipsToBounds = true
            view.addSubview(zoomImageView)
            zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOut)))
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    let height  = self.view.frame.width / position.width * position.height / 6
                    let y = self.view.frame.height / 2 -  height / 2
                    self.zoomImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
                    self.blackBackgroungView.alpha = 1
                    self.navBarBack.alpha = 1
                    self.tabBarBack.alpha = 1
                
                }, completion: nil)
            
        }
        
    
    }
    func zoomOut() {
        
        if let position = imageView!.superview?.convert(imageView!.frame, to: nil){
            UIView.animate(withDuration: 0.75, animations: {
                
            })
        UIView.animate(withDuration: 0.75, animations: {
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
         collectionView?.backgroundColor = UIColor.white
        navigationItem.title = produto?.titulo
        collectionView?.register(SingleCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(HeaderSingleCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: cellidHeader)
        
       
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SingleCell
        
        
        cell.produto = produto
        cell.singleController = self
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 400)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
         return CGSize(width: view.frame.width, height: 240)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header  = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellidHeader, for: indexPath) as! HeaderSingleCell
        
        header.produto = produto
        header.singleController = self
        return header
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}
