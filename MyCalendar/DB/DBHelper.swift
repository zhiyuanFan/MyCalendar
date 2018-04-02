//
//  DBHelper.swift
//  MyCalendar
//
//  Created by Jason Fan on 30/03/2018.
//  Copyright © 2018 zyFan. All rights reserved.
//

import UIKit
import CoreData


class DBHelper {
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelPath = Bundle.main.url(forResource: "MyCalendarDB", withExtension: ".momd")!
        return NSManagedObjectModel(contentsOf: modelPath)!
    }()
    
    lazy var manageObjectContext: NSManagedObjectContext = {
        let moc = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        moc.persistentStoreCoordinator = persistentStoreCoordinator
        return moc
    }()
    
    lazy var persistentStoreCoordinator : NSPersistentStoreCoordinator = {
        var dbPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
        dbPath?.appendPathComponent("calendar.sqlite")
        let psc = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        do {
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: dbPath, options: nil)
        } catch let error as NSError {
            print("addPersistentStore error: \(error)")
        }
        return psc
    }()
    
    static let shared = DBHelper()
    
//    class func shared() -> DBHelper {
//        return sharedMOC
//    }
    
}
