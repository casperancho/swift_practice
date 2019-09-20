//
//  CoreDataManager.swift
//  coreDataTestApp
//
//  Created by  Azat Biktimirov on 14/01/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

/* #Overview
 - usage example
 
 // init core data manager
 let coreDataManager = CoreDataManager(withDataModelName: "coreDataTestApp", bundle: .main)
 
 // add some objects of entity
 let testObj = SomeEntity(context: coreDataManager.mainContext)
 testObj.name = "kekus2"
 
 // save managedobjectcontext
 coreDataManager.saveContext(synchronously: true)
 
 // fetch
 let fetchResult = coreDataManager.fetchObjects(entity: SomeEntity.self, context: coreDataManager.mainContext)
 
 for data in fetchResult {
 print(data.name ?? "nil")
 }
 */

import Foundation
import CoreData

class CoreDataManager {
    var dataModelName: String
    var dataModelBundle: Bundle
    var persistentStoreName: String
    
    // MARK: - Init
    
    init(withDataModelName dataModelName: String, bundle: Bundle) {
        self.dataModelName = dataModelName
        self.persistentStoreName = dataModelName
        self.dataModelBundle = bundle
    }
    
    // MARK: - Core Data stack
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = dataModelBundle.url(forResource: dataModelName, withExtension: "momd") else {
            fatalError("Failed to find data model file.")
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to create managed object model")
        }
        
        return managedObjectModel
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        let url = CoreDataManager.applicationDocumentsDirectory.appendingPathComponent("\(persistentStoreName).sqlite")
        
        let options = [
            NSMigratePersistentStoresAutomaticallyOption: true,
            NSInferMappingModelAutomaticallyOption: true
        ]
        
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch let error as NSError {
            fatalError("Failed to init persistent data: \(error.localizedDescription)")
        } catch {
            fatalError("Failed to init persistent data")
        }
        
        return coordinator
    }()
    
    // We use stack with a private context as the root with public context as its child
    // This method provides async write to disk
    lazy var privateContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        return context
    }()
    
    lazy var mainContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.parent = privateContext
        return context
    }()
    
    private static var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count - 1]
    }()
    
    // MARK: - Child context
    
    public func createChildContext(withParent parent: NSManagedObjectContext) -> NSManagedObjectContext {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.parent = parent
        return managedObjectContext
    }
    
    // MARK: - Fetching
    
    public func fetchObjects<T: NSManagedObject>(entity: T.Type,
                                                 predicate: NSPredicate? = nil,
                                                 sortDescriptors: [NSSortDescriptor]? = nil,
                                                 context: NSManagedObjectContext,
                                                 fetchBatchSize: Int? = nil) -> [T] {
        
        let request = NSFetchRequest<T>(entityName: String(describing: entity))
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        
        if let fetchBatchSize = fetchBatchSize {
            request.fetchBatchSize = fetchBatchSize
        }
        
        do {
            return try context.fetch(request)
        } catch let error as NSError {
//            Logger.shared.writeSystemLog(error.localizedDescription)
            return [T]()
        }
    }
    
    public func fetchObject<T: NSManagedObject>(entity: T.Type,
                                                predicate: NSPredicate? = nil,
                                                sortDescriptors: [NSSortDescriptor]? = nil,
                                                context: NSManagedObjectContext) -> T? {
        
        let request = NSFetchRequest<T>(entityName: String(describing: entity))
        
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        request.fetchLimit = 1
        
        do {
            return try context.fetch(request).first
        } catch let error as NSError {
//            Logger.shared.writeSystemLog(error.localizedDescription)
            return nil
        }
    }
    
    // MARK: - Deleting
    
    public func delete(_ object: NSManagedObject) {
        mainContext.delete(object)
    }
    
    public func delete(_ object: NSManagedObject, in context: NSManagedObjectContext) {
        context.delete(object)
    }
    
    public func delete(_ objects: [NSManagedObject]) {
        for object in objects {
            mainContext.delete(object)
        }
    }
    
    public func delete(_ objects: [NSManagedObject], in context: NSManagedObjectContext) {
        for object in objects {
            context.delete(object)
        }
    }
    
    public func deleteAllObjects() {
        for entityName in managedObjectModel.entitiesByName.keys {
            
            let request = NSFetchRequest<NSManagedObject>(entityName: entityName)
            request.includesPropertyValues = false
            
            do {
                for object in try mainContext.fetch(request) {
                    mainContext.delete(object)
                }
            } catch let error as NSError {
//                Logger.shared.writeSystemLog(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Saving
    
    public func saveContext(synchronously: Bool, completion: ((NSError?) -> Void)? = nil) {
        var mainContextSaveError: NSError?
        
        if mainContext.hasChanges {
            mainContext.performAndWait {
                do {
                    try mainContext.save()
                } catch var error as NSError {
                    mainContextSaveError = error
                }
            }
        }
        
        guard mainContextSaveError == nil else {
            completion?(mainContextSaveError)
            return
        }
        
        func savePrivateContext() {
            do {
                try privateContext.save()
                completion?(nil)
            } catch let error as NSError {
                completion?(error)
            }
        }
        
        if privateContext.hasChanges {
            if synchronously {
                privateContext.performAndWait(savePrivateContext)
            } else {
                privateContext.perform(savePrivateContext)
            }
        }
    }
}

