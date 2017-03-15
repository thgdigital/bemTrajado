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
        
        
//        let listaControle = ListaDesejosController(collectionViewLayout: UICollectionViewFlowLayout())
//        
//        let carrinho = UINavigationController(rootViewController: listaControle)
//        carrinho.tabBarItem.image = UIImage(named: "ic_local_grocery_store")
//        carrinho.tabBarItem.title = "Listar de desejos"
      //  var carrinho = UINavigationController()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let  viewController = storyboard.instantiateViewController(withIdentifier: "DesejoController") as! DesejoController
           let carrinho = UINavigationController(rootViewController: viewController)
        
        carrinho.tabBarItem.image = UIImage(named: "ic_local_grocery_store")
        carrinho.tabBarItem.title = "Listar de desejos"
        
        
        
        let localicao = LocalizacaoController(collectionViewLayout: UICollectionViewFlowLayout())
        let navegacaoLocalicao = UINavigationController(rootViewController: localicao)
        navegacaoLocalicao.tabBarItem.image = UIImage(named: "ic_place")
        navegacaoLocalicao.tabBarItem.title = "Localização"
        
        let  configController = storyboard.instantiateViewController(withIdentifier: "ConfigController") as! ConfigController
        let config =  UINavigationController(rootViewController: configController)
        config.tabBarItem.image = UIImage(named: "ic_view_headline")
        config.tabBarItem.title = "Minha Conta"
        config.navigationItem.title = "Configurações"
        
        
        let chat = UINavigationController(rootViewController: ChatController())
        chat.tabBarItem.image = UIImage(named: "chat")
        chat.tabBarItem.title = "Chat"
        chat.navigationItem.title = "Chat"
        if verifica(){
        }
        
        viewControllers = [navigaitorHome,carrinho,chat, navegacaoLocalicao, config]
        
        tabBar.isTranslucent = false
    }
    func verifica() -> Bool{
        
        if let  _ = self.storyboard?.instantiateViewController(withIdentifier: "DesejoController") as? DesejoController{
            return true
        }
        return false
    }
}
