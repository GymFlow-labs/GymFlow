//
//  Exercise1RMRepositories.swift
//  GymFlow
//
//  Created by Artem Kriukov on 12.10.2025.
//

import CoreData
import Foundation

protocol Exercise1RMProtocol {
    func save(_ exercise: Exercise)
    func fetchAll() -> [Exercise]
}

final class Exercise1RMRepositories: Exercise1RMProtocol {
    private let coreDataStack: CoreDataStack
    private let context: NSManagedObjectContext
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.context = coreDataStack.context
    }
    
    func save(_ exercise: Exercise) {
        context.perform {
            let entity = ExerciseEntityMapper.toEntity(exercise, context: self.context)
            entity.id = exercise.id
            entity.nameEn = exercise.name
            entity.nameRu = exercise.nameRu
            entity.descr = exercise.description
            entity.category = exercise.category

            do {
                try self.context.save()
                print("Saved Exercise1RM:", exercise.name)
            } catch {
                self.context.rollback()
                print("Save error Exercise1RM:", error)
            }
        }
    }
    
    func fetchAll() -> [Exercise] {
        let request: NSFetchRequest<Exercise1RM> = Exercise1RM.fetchRequest()
        let entities = (try? context.fetch(request)) ?? []
        return entities.map { ExerciseEntityMapper.toDomain($0) }
    }
    
    static func fetch(by id: String, in context: NSManagedObjectContext) throws -> Exercise1RM? {
        let req: NSFetchRequest<Exercise1RM> = Exercise1RM.fetchRequest()
        req.fetchLimit = 1
        req.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        return try context.fetch(req).first
    }
}

extension Exercise1RM {
    static func fetchRequestForID(_ id: String) -> NSFetchRequest<Exercise1RM> {
        let request: NSFetchRequest<Exercise1RM> = Exercise1RM.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "id == %@", id)
        return request
    }
}
