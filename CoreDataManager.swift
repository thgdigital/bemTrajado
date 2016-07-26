//
//  CoreDataManager.swift
//  Core Data Tutorial
//
//  Created by Jorge Henrique P. Garcia on 10/21/15.
//  Copyright © 2015 Jhpg. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    static let sharedInstance = CoreDataManager()
    
    var entityObj: NSManagedObject!   //Recebe o objeto do managedContext
    
    lazy var managedContext: NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var c = appDelegate.managedObjectContext
        return c
    }()
    
    //MARK: - CRUD -
    
    /// Cria nova entidade no managedContext
    func new(entityName: String) -> NSManagedObject{
        return NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: managedContext)
    }
    
    func saveObj(obj: NSManagedObject) {
        do {
            try obj.managedObjectContext?.save()
        } catch let error as NSError {
            print("Could not save. Error: \(error), \(error.userInfo)")
        }
    }
    
    /// Delete an object
    func deleteObj(obj: NSManagedObject) {

        managedContext.deleteObject(obj)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not delete. Error: \(error), \(error.userInfo)")
        }
    }
    
    /// Custom - All searches can use it
    func customSearch(entityName: String, predicate: NSPredicate, sortDescriptor: NSSortDescriptor) -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest(entityName: entityName)
        
        fetchRequest.sortDescriptors = [sortDescriptor]  // Sort descriptor object that sorts ( ORDER BY )
        fetchRequest.predicate = predicate               // Predicate filters out ( WHERE )
        
        var fetchedResults: [NSManagedObject]?
        
        do {
            try fetchedResults = self.managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
        } catch let error as NSError {
            print("Error: \(error)")
        }
        
        return fetchedResults
    }
}



