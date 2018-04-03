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
    
    class func fetchEventsDateSet() -> [String] {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Events")
        do {
            if let array = try DBHelper.shared.manageObjectContext.fetch(request) as? [Events], array.count != 0 {
                var dateArray = [String]()
                for event in array {
                    dateArray.append(event.create_time!)
                }
                return Array(Set(dateArray))
            }
        } catch let error as NSError {
            print("fetch Error: \(error)")
        }
        return []
    }

    
    class func insertEvent(content: String, date: Date) -> Events? {
        
//        let maxId = getMaxId()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Events", in: DBHelper.shared.manageObjectContext) else { return nil }
        let event = NSManagedObject(entity: entity, insertInto: DBHelper.shared.manageObjectContext)
//        event.setValue(maxId, forKey: "id")
        event.setValue(content, forKey: "content")
        let dateStr = formatter.string(from: date)
        event.setValue(dateStr, forKey: "create_time")
        do {
            try DBHelper.shared.manageObjectContext.save()
            return event as? Events
        } catch let error as NSError {
            print("insert event error: \(error)")
        }
        return nil
    }
    
//    class func getMaxId() -> Int64 {
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Events")
//         request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
//        do {
//            let events = try DBHelper.shared.manageObjectContext.fetch(request) as? [Events]
//            guard let array = events, array.count > 0, let lastEvent = array.last else { return 0 }
//            return (lastEvent.id + 1)
//
//        } catch let error as NSError {
//            print("fetch Error: \(error)")
//        }
//        return 0
//    }
    
    class func deleteEvent(_ event: Events) {
        DBHelper.shared.manageObjectContext.delete(event)
        do {
            try DBHelper.shared.manageObjectContext.save()
        } catch let error as NSError {
            print("deleteEvent error: \(error)")
        }
    }

}
