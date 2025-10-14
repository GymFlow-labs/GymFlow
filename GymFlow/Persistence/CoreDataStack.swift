//
//  CoreDataStack.swift
//  GymFlow
//
//  Created by Artem Kriukov on 11.10.2025.
//

import CoreData
import Foundation

final class CoreDataStack {
    
    lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ExerciseDataModel")
        container.loadPersistentStores { _, error in
            if let error {
                assertionFailure("Ошибка при загрузке хранилища Core Data: \(error)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
