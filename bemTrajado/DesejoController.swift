//
//  DesejoController.swift
//  bemTrajado
//
//  Created by Thiago Santos on 09/11/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class DesejoController: UIViewController, UITableViewDataSource, UITableViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    @IBOutlet weak var tableView: UITableView!
    let cdManager = CoreDataManager.sharedInstance
   
    var produts : [Produtos]?
    var titleRightBt = UIBarButtonItem(title: "Excluir", style: .plain, target: self, action: #selector(deleteCells))
    
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

        
        return produts
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = " Lista de desejos"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        navigationItem.rightBarButtonItem =  UIBarButtonItem(title: "Excluir", style: .plain, target: self, action: #selector(deleteCells))
        
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        self.tableView.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }
    
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let atrributed = NSAttributedString(string:"Opss lista de desejo vazio", attributes:
            [NSForegroundColorAttributeName: UIColor.lightGray])
        return atrributed
    }
    func configTitleItemBar(){
        self.navigationItem.rightBarButtonItem?.title =  tableView.isEditing ? "Cancelar" : "Excluir"
           
    }
    func deleteCells()  {
        if tableView.isEditing  == false {
            self.tableView.setEditing(true, animated: true)
             self.navigationItem.rightBarButtonItem?.title = "Cancelar"
            
        }else{
             self.navigationItem.rightBarButtonItem?.title = "Excluir"
            self.tableView.setEditing(false, animated: true)
          
        }
        
       
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         produts =  buscarDados()
        tableView.reloadData()
        
        configTitleItemBar()
    }
    
    

}
extension DesejoController {
    
    func tableView( _ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if (self.tableView.isEditing) {
            return .delete;
        }
        return .none;
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//
          
            let predicate = NSPredicate(value: true)
            let ordeby = NSSortDescriptor(key: "id", ascending: true)
               let listas = cdManager.customSearch("Produto", predicate: predicate, sortDescriptor: ordeby) as! [Produto]
            
       
           guard let media = listas.filter({$0.id == produts?[indexPath.row].id}).first else {return}
            cdManager.deleteObj(media)
          
            
            produts?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
             tableView.separatorStyle = .none
            
          
            
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = produts?.count{
         
            return count
        }
       return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! DesejoCell
        
        cell.layoutCell(produts?[indexPath.row])
        
        return cell
    }
}
