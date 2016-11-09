//
//  ListaDesejosController.swift
//  bemTrajado
//
//  Created by EntrevistaTeste on 26/07/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class ListaDesejosController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    fileprivate let cellId = "cellId"
     let cdManager = CoreDataManager.sharedInstance
    var produts : [Produtos]?
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         produts =  buscarDados()
        collectionView?.dataSource = self
        collectionView?.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = " Lista de desejos"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(ListaCell.self, forCellWithReuseIdentifier: cellId)
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: #selector(deleteC))
//       navigationItem.rightBarButtonItem = editButtonItem
        if let indexPath = getIndexPathForSelectedCell() {
            highlightCell(indexPath, flag: false)
        }
        
       // toolBar.hidden = true
    }
//    func deleteCells(sender: AnyObject) {
//        
//       // var deletedFruits:[Fruit] = []
//        
//        let indexpaths = collectionView?.indexPathsForSelectedItems()
//       
//        if let indexpaths = indexpaths {
//            
//            for item  in indexpaths {
//                collectionView?.deselectItemAtIndexPath((item), animated: true)
//                // fruits for section
//                //let sectionfruits = dataSource.fruitsInGroup(item.section)
//                deletedFruits.append(sectionfruits[item.row])
//            }
//            
//           // dataSource.deleteItems(deletedFruits)
//            
//            collectionView?.deleteItemsAtIndexPaths(indexpaths)
//        }
//    }
//

    
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
    
    func getIndexPathForSelectedCell() -> IndexPath? {
        
        var indexPath:IndexPath?
        
        if collectionView?.indexPathsForSelectedItems!.count > 0 {
            indexPath = collectionView?.indexPathsForSelectedItems![0]
        }
        return indexPath
    }
    
    func highlightCell(_ indexPath : IndexPath, flag: Bool) {
        
        let cell = collectionView?.cellForItem(at: indexPath)
        
        if flag {
            cell?.contentView.backgroundColor = UIColor.magenta
        } else {
            cell?.contentView.backgroundColor = nil
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        highlightCell(indexPath, flag: true)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        highlightCell(indexPath, flag: false)
        
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        collectionView?.allowsMultipleSelection = editing
        //toolBar.hidden = !editing
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = produts?.count{
            return count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 125)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ListaCell
        
        cell.produto = produts?[(indexPath as NSIndexPath).item]
//        cell.left = view.leftAnchor
//        cell.centerV = view.centerXAnchor
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsetsMake(5, 0,5, 0)
//        
//    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}
//extension ListaDesejosController  : UICollectionViewDataSource {
//    
//     func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        
//        if let count = produts?.count{
//            return count
//        }
//        return 0
//    }
//}
