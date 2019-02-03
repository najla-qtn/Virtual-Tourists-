//
//  coredataStack.swift
//  virtualTourists
//
//  Created by Najla Al qahtani on 1/20/19.
//  Copyright © 2019 Najla Al qahtani. All rights reserved.
//

import Foundation
import CoreData
import UIKit
//manages four obj: obj-contexts, obj-model, persistance store coordinator, persistance container
final class CoreDataStack {
    //1-hold persistance container instance
    //2-hold the persistance store
    //3-access the context
    
    
    static let shared = CoreDataStack()
    var errorHandler: (Error) -> Void = {_ in }
    //1
    lazy var persistentContainer: NSPersistentContainer = {
        //pass the model name which is "pin-data"
        let container = NSPersistentContainer(name: "pin-data")
        //2
        //load the persistance store
        container.loadPersistentStores(completionHandler: { [weak self](storeDescription, error) in
            if let error = error {
                NSLog("CoreData error \(error), \(error._userInfo)")
                self?.errorHandler(error)
            }
        })
        return container
    }()
    //3
    lazy var viewContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    func saveContext() {
        if self.persistentContainer.viewContext.hasChanges {
            do {
                try self.persistentContainer.viewContext.save()
            } catch {
                NSLog("Error occured while saving persistent store: \(error), \(error._userInfo)")
                self.errorHandler(error)
            }
        }
    }
    
    func performForegroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        self.viewContext.perform {
            block(self.viewContext)
        }
    }
    
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        self.persistentContainer.performBackgroundTask(block)
    }
}

