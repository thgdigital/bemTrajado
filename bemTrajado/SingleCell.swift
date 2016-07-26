//
//  SingleCell.swift
//  bemTrajado
//
//  Created by Admin on 02/07/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit
import Kingfisher


class SingleCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private let cellId = "cellId"
   let cdManager = CoreDataManager.sharedInstance

    
    var singleController : SingleProdutoController?
    
    
    var produto: Produtos? {
        didSet {
            if let title = produto?.titulo{
                nameLabel.text = title
            }
            if let descricao = produto?.descricao {
                text.text = descricao
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
        let label = UILabel()
        label.text = "Blusa da lacoste"
        label.numberOfLines = 2
        label.font = UIFont.systemFontOfSize(14)
        return label
    }()
    let buyBotao: UIButton = {
        let botao = UIButton(type: .System)
        botao.setTitle("Adicionar a Lista", forState: .Normal)
       botao.setTitleColor(UIColor.whiteColor(), forState: .Normal)
       // botao.layer.borderColor = UIColor(red: 0, green: 129/255, blue: 250/255, alpha: 1).CGColor
        //botao.layer.borderWidth = 1
        botao.backgroundColor = UIColor.rgb(194, green: 31, blue: 31)
        botao.titleLabel?.font = UIFont.boldSystemFontOfSize(14)
        return botao
    }()
    let text: UILabel = {
        let texto = UILabel()
        texto.text = "Ao contrário do que se acredita, Lorem Ipsum não é simplesmente um texto randômico."
        texto.font = UIFont.systemFontOfSize(14)
        texto.numberOfLines = 2
      //  texto.textColor = UIColor.darkTextColor()
        return texto
    }()
    
    let namePreco: UILabel = {
        let label = UILabel()
        label.text = "R$ 190, 00"
        label.font = UIFont.boldSystemFontOfSize(12)
        
        
        return label
    }()
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = produto?.galeria?.count{
            return count
        }
        return 0
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! GalerialCell
        cell.galeria = produto?.galeria?[indexPath.item]
        cell.singleController = singleController
       
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(200, 100)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 14, 0, 14)
        
    }
    func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        collectionView.collectionViewLayout.invalidateLayout()
    }
    override func setupViews() {
        super.setupViews()
        
        addSubview(collectionView)
        addSubview(nameLabel)
        addSubview(buyBotao)
        addSubview(text)
        addSubview(namePreco)
     
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        
        addConstraintsWithFormat("H:|-14-[v0]-14-|", views: nameLabel)
        addConstraintsWithFormat("H:|-14-[v0]-14-|", views: namePreco)
        
        addConstraintsWithFormat("H:|-14-[v0]-14-|", views: buyBotao)
        addConstraintsWithFormat("H:|-14-[v0]|", views: text)
        
        addConstraintsWithFormat("V:[v0]-5-[v1]-5-[v2]-5-[v3(50)]-80-|", views:  nameLabel, namePreco, text, buyBotao)
        
        addConstraintsWithFormat("V:|-5-[v0(200)]", views:  collectionView)
        
        
        collectionView.registerClass(GalerialCell.self, forCellWithReuseIdentifier: cellId)
        
        buyBotao.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pedido)))
    }
    func pedido(){
        let newPedido = cdManager.new("Produto") as! Produto
        if let id = produto?.id, image = produto?.image, marca_id = produto?.marca_id , titulo = produto?.titulo, created_at = produto?.created_at, updated_at = produto?.updated_at, qtd = produto?.qtd, preco = produto?.preco, descricao = produto?.descricao{
            
            newPedido.id            = id
            newPedido.image         = image
            newPedido.marca_id      = marca_id
            newPedido.titulo        = titulo
            newPedido.created_at    = created_at
            newPedido.updated_at    = updated_at
            newPedido.qtd           = qtd
            newPedido.preco         = preco
            newPedido.name          = titulo
            newPedido.descricao     = descricao
            cdManager.saveObj(newPedido)
        }
        
        
    }
}



