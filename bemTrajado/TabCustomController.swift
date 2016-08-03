//
//  TabCustomController.swift
//  bemTrajado
//
//  Created by Admin on 25/06/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit

class TabCustomController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        let homeControler = HomeController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigaitorHome = UINavigationController(rootViewController: homeControler)
        homeControler.title = "Home"
        homeControler.navigationItem.title = "teste"
        homeControler.tabBarItem.image = UIImage(named: "ic_home")
        
        
        let listaControle = ListaDesejosController(collectionViewLayout: UICollectionViewFlowLayout())
        
        let carrinho = UINavigationController(rootViewController: listaControle)
        carrinho.tabBarItem.image = UIImage(named: "ic_local_grocery_store")
        carrinho.tabBarItem.title = "Listar de desejos"
        
        
        let localicao = LocalizacaoController(collectionViewLayout: UICollectionViewFlowLayout())
        let navegacaoLocalicao = UINavigationController(rootViewController: localicao)
        navegacaoLocalicao.tabBarItem.image = UIImage(named: "ic_place")
        navegacaoLocalicao.tabBarItem.title = "Localização"
        
        
        let config = UINavigationController(rootViewController: ConfigController())
        config.tabBarItem.image = UIImage(named: "ic_view_headline")
        config.tabBarItem.title = "Minha Conta"
        config.navigationItem.title = "Configurações"
        
        viewControllers = [navigaitorHome, carrinho, navegacaoLocalicao, config]
        //viewControllers = [navigaitorHome, navegacaoLocalicao, config]
        
        tabBar.translucent = false
    }
}
