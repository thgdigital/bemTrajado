//
//  SingleCell.swift
//  bemTrajado
//
//  Created by Admin on 02/07/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit
import SDWebImage


class SingleCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    fileprivate let cellId = "cellId"
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
            print(produto?.galeria?.count)
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
        let label = UILabel()
        label.text = "Blusa da lacoste"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    let buyBotao: UIButton = {
        let botao = UIButton(type: .system)
        botao.setTitle("Adicionar a Lista", for: UIControlState())
       botao.setTitleColor(UIColor.white, for: UIControlState())
    
        botao.backgroundColor = UIColor.rgb(194, green: 31, blue: 31)
        botao.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return botao
    }()
    let text: UILabel = {
        let texto = UILabel()
        texto.text = "Ao contrário do que se acredita, Lorem Ipsum não é simplesmente um texto randômico."
        texto.font = UIFont.systemFont(ofSize: 14)
        texto.numberOfLines = 0
        return texto
    }()
    
    let namePreco: UILabel = {
        let label = UILabel()
        label.text = "R$ 190, 00"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        
        
        return label
    }()
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = produto?.galeria?.count{
            return count
        }
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! GalerialCell
        cell.galeria = produto?.galeria?[(indexPath as NSIndexPath).item]
        cell.singleController = singleController
       
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard isGallary() else{
            return CGSize(width: 0, height: 0)
        }
        return CGSize(width: 200, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 14, 0, 14)
        
    }
    func viewWillTransitionToSize(_ size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    
     private func isGallary() -> Bool {
        
        guard let _ =  produto?.galeria?.count else{
            return false
        }
   
        return true
    }
    private func setupLayout(){
        guard  isGallary() else {
            addConstraintsWithFormat("V:|-5-[v0]-5-[v1]-5-[v2]-5-[v3(50)]", views:  nameLabel, namePreco, text, buyBotao)
            addConstraintsWithFormat("V:|-5-[v0(0)]", views:  collectionView)
         
          return
        }
        addConstraintsWithFormat("V:[v0]-5-[v1]-5-[v2]-5-[v3(50)]-30-|", views:  nameLabel, namePreco, text, buyBotao)
        addConstraintsWithFormat("V:|-5-[v0(200)]", views:  collectionView)
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
        collectionView.register(GalerialCell.self, forCellWithReuseIdentifier: cellId)
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        
        addConstraintsWithFormat("H:|-5-[v0]-14-|", views: nameLabel)
        addConstraintsWithFormat("H:|-5-[v0]-14-|", views: namePreco)
        
        addConstraintsWithFormat("H:|-5-[v0]-14-|", views: buyBotao)
        addConstraintsWithFormat("H:|-5-[v0]|", views: text)
        setupLayout()
        
        buyBotao.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pedido)))
    }
    func pedido(){
        let newPedido = cdManager.new("Produto") as! Produto
        if let id = produto?.id, let image = produto?.image, let marca_id = produto?.marca_id , let titulo = produto?.titulo, let created_at = produto?.created_at, let updated_at = produto?.updated_at, let qtd = produto?.qtd, let preco = produto?.preco, let descricao = produto?.descricao{
            
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



