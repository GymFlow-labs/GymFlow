//
//  CoreDataManager.swift
//  GymFlow
//
//  Created by Artem Kriukov on 11.10.2025.
//

import CoreData
import Foundation

final class CoreDataStack {
    static let shared = CoreDataStack()
    private init() {}
    
    lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ExerciseDataModel")

        // Если хотите отключить WAL и видеть данные в одном .sqlite:
        // let desc = container.persistentStoreDescriptions.first
        // desc?.setOption(["journal_mode": "DELETE"] as NSDictionary, forKey: NSSQLitePragmasOption)

        container.loadPersistentStores { desc, error in
            if let error = error {
                assertionFailure("Ошибка при загрузке хранилища Core Data: \(error)")
                return
            }
            if let url = desc.url {
                print("Store URL:", url.path)
                print("WAL:", url.appendingPathExtension("wal").path)
                print("SHM:", url.appendingPathExtension("shm").path)
            } else {
                print("Нет URL у persistent store")
            }
        }
        return container
    }()
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                print("saved")
            } catch {
                context.rollback()
                let nserror = error as NSError
                print("error")
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
