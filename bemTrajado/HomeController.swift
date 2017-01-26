//
//  ViewController.swift
//  bemTrajado
//
//  Created by Admin on 24/06/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit
import Firebase
class HomeController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    
    fileprivate let cellId = "cellId"
    fileprivate let cellHeaderId = "cellHeaderId"
    var categorias :  [Categoria]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.white
        navigationItem.title = "Bem Trajados Multimarcas"
        
    
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Bem Trajados Multimarcas"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        Categoria.categoriasProdutos { (categoria) in

            self.categorias = categoria
            self.collectionView?.reloadData()
        }
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(ProdutoHomeCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.register(HomeHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: cellHeaderId)
         collectionView?.alwaysBounceVertical = true;
    }
    
    func showAppDetailForApp(_ produto: Produtos) {
        let layout = UICollectionViewFlowLayout()
        let singleProdutoController = SingleProdutoController(collectionViewLayout: layout)
        singleProdutoController.produto = produto
        navigationController?.pushViewController(singleProdutoController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
         return CGSize(width: view.frame.width, height: 200)
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellHeaderId, for: indexPath)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let cout = categorias?.count {
            return cout
        }
        return 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProdutoHomeCell
        
        cell.categoria = categorias?[(indexPath as NSIndexPath).item]
        cell.homeController = self
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 240)
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    func handleLogout() {
        
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
}





