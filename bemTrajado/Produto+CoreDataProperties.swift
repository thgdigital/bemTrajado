//
//  Produto+CoreDataProperties.swift
//  bemTrajado
//
//  Created by EntrevistaTeste on 26/07/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Produto {

    @NSManaged var id: NSNumber?
    @NSManaged var name: String?
    @NSManaged var titulo: String?
    @NSManaged var descricao: String?
    @NSManaged var image: String?
    @NSManaged var preco: String?
    @NSManaged var marca_id: String?
    @NSManaged var qtd: String?
    @NSManaged var created_at: String?
    @NSManaged var updated_at: String?

}
