//
//  PersistanceManager.swift
//  Core Data Learning
//
//  Created by AshutoshD on 26/03/20.
//  Copyright © 2020 ravindraB. All rights reserved.
//

import Foundation
import CoreData

final class PersistanceManager {
    
    private init() {}
    static let shared = PersistanceManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Core_Data_Learning")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var context = persistentContainer.viewContext
    
    // MARK: - Core Data Saving support

    func save() {
        if context.hasChanges {
            do {
                try context.save()
                print("Save Successfully")
            } catch {
             
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T]{
        
        let entityName = String(describing: objectType)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do{
            let fetchedObject = try! context.fetch(fetchRequest)as? [T]
            return fetchedObject ?? [T]()
        }catch{
            print(error)
            return[T]()
        }
    }
    
//    func delete(_ object : NSManagedObject){
//        context.delete(object)
//        save()
//    }
    
     func delete(user : User) -> Bool {
        context.delete(user)
        do {
            try! context.save()
            return true
        }catch{
            return false
        }
    }
    
    
   
}
