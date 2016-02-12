//
//  CoreDataStack.swift
//  CoreDataStackDay1.git CoreDataStackDayOne
//
//  Created by Lin Wei on 2/12/16.
//  Copyright © 2016 Lin Wei. All rights reserved.
//

import Foundation
// 1
import CoreData

//2
class CoreDataStack {
    
    //3 
    let mangedObjectContext: NSManagedObjectContext?
    
    let persistentStoreCooordinator: NSPersistentStoreCoordinator?
    
    let managedObjectModel: NSManagedObjectModel?
    
    init(){
        
        let bundle = NSBundle.mainBundle()
        let modelURL =  bundle.URLForResource("Data", withExtension: "momd")!
        
        managedObjectModel = NSManagedObjectModel(contentsOfURL: modelURL)
        
        persistentStoreCooordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel!)
        
        mangedObjectContext = NSManagedObjectContext()
        mangedObjectContext?.persistentStoreCoordinator = persistentStoreCooordinator
        
        
        //5
        let appDirectory = applicationDocumentDirectory()
        let storeURL = appDirectory.URLByAppendingPathComponent("Data")
        let migrateOption = [NSMigratePersistentStoresAutomaticallyOption: true]
        
        var err: NSError?
        do {
            try persistentStoreCooordinator?.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: migrateOption)
            
        } catch let error1 as NSError {
            err = error1
            
            
        }
        if (err != nil){
            
            print("failed to create store")
            
            abort()
        }
        
    }
    
    
    //4
    
    func applicationDocumentDirectory() -> NSURL {
    
    let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.DocumentationDirectory, inDomains: .UserDomainMask)
        
        return urls[0];
    
    }
    
    
    
    
    
}