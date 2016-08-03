//
//  ListaDesejosController.swift
//  bemTrajado
//
//  Created by EntrevistaTeste on 26/07/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit

class ListaDesejosController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let cellId = "cellId"
     let cdManager = CoreDataManager.sharedInstance
    var produts : [Produtos]?
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
         produts =  buscarDados()
        collectionView?.dataSource = self
        collectionView?.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleLabel = UILabel(frame: CGRectMake(0, 0, view.frame.width - 32, view.frame.height))
        titleLabel.text = "Lista de desejos"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.systemFontOfSize(20)
        navigationItem.titleView = titleLabel
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.registerClass(ListaCell.self, forCellWithReuseIdentifier: cellId)
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: #selector(deleteC))
       navigationItem.rightBarButtonItem = editButtonItem()
        if let indexPath = getIndexPathForSelectedCell() {
            highlightCell(indexPath, flag: false)
        }
        
       // toolBar.hidden = true
    }
    func deleteCells(sender: AnyObject) {
        
       // var deletedFruits:[Fruit] = []
        
        let indexpaths = collectionView?.indexPathsForSelectedItems()
       
        if let indexpaths = indexpaths {
            
            for item  in indexpaths {
                collectionView?.deselectItemAtIndexPath((item), animated: true)
                // fruits for section
                //let sectionfruits = dataSource.fruitsInGroup(item.section)
                deletedFruits.append(sectionfruits[item.row])
            }
            
           // dataSource.deleteItems(deletedFruits)
            
            collectionView?.deleteItemsAtIndexPaths(indexpaths)
        }
    }
}

    
     func buscarDados() -> [Produtos] {
        let predicate = NSPredicate(value: true)
        let ordeby = NSSortDescriptor(key: "id", ascending: true)
        var produts = [Produtos]()

        let lista = cdManager.customSearch("Produto", predicate: predicate, sortDescriptor: ordeby) as! [Produto]
        
        if lista.isEmpty{
            
            return produts
        }
        for data in lista {
            let produto = Produtos()
            
            produto.id = data.id
            produto.titulo = data.name
            produto.image = data.image
            produto.preco = data.preco
            produto.marca_id = data.marca_id
            produto.descricao = data.descricao
            produto.qtd = data.qtd
            produto.created_at = data.created_at
            produto.updated_at = data.updated_at
            produts.append(produto)
        }
        
        self.collectionView?.reloadData()
      
        return produts
        
        
        
    }
    
    func getIndexPathForSelectedCell() -> NSIndexPath? {
        
        var indexPath:NSIndexPath?
        
        if collectionView?.indexPathsForSelectedItems()!.count > 0 {
            indexPath = collectionView?.indexPathsForSelectedItems()![0]
        }
        return indexPath
    }
    
    func highlightCell(indexPath : NSIndexPath, flag: Bool) {
        
        let cell = collectionView?.cellForItemAtIndexPath(indexPath)
        
        if flag {
            cell?.contentView.backgroundColor = UIColor.magentaColor()
        } else {
            cell?.contentView.backgroundColor = nil
        }
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        highlightCell(indexPath, flag: true)
        
    }
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        highlightCell(indexPath, flag: false)
        
    }
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        collectionView?.allowsMultipleSelection = editing
        //toolBar.hidden = !editing
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = produts?.count{
            return count
        }
        return 0
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 200)
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! ListaCell
        
        cell.produto = produts?[indexPath.item]
        cell.left = view.leftAnchor
        cell.centerV = view.centerXAnchor
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
//        return UIEdgeInsetsMake(0, 14, 0, 14)
//        
//    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}
//extension ListaDesejosController  : UICollectionViewDataSource {
//    
//    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        
//        if let count = produts?.count{
//            return count
//        }
//        return 0
//    }
//}