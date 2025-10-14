//
//  WorkoutRecordsRepositories.swift
//  GymFlow
//
//  Created by Artem Kriukov on 12.10.2025.
//

import CoreData
import Foundation

protocol WorkoutRecordRepositoryProtocol {
    func addRecord(for exercise: Exercise, date: Date, weight: Double) async throws
    func fetchRecords(forExerciseID id: String) -> [WorkoutRecord]
}

final class WorkoutRecordsRepositories: WorkoutRecordRepositoryProtocol {
    private let coreDataStack: CoreDataStack
    private let context: NSManagedObjectContext
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.context = coreDataStack.context
    }
    
    func addRecord(for exercise: Exercise, date: Date, weight: Double) async throws {
        try await context.perform {
            let exerciseEntity: Exercise1RM
            if let existing = try Exercise1RMRepositories.fetch(by: exercise.id, in: self.context) {
                exerciseEntity = existing
            } else {
                exerciseEntity = ExerciseEntityMapper.toEntity(exercise, context: self.context)
            }
            
            _ = ExerciseRecordMapper.toEntity(
                weight: weight,
                date: date,
                exerciseEntity: exerciseEntity,
                context: self.context
            )
            
            self.coreDataStack.saveContext()
        }
    }
    
    func fetchRecords(forExerciseID id: String) -> [WorkoutRecord] {
        guard let exerciseEntity = try? context.fetch(Exercise1RM.fetchRequestForID(id)).first else {
            return []
        }
        
        let req: NSFetchRequest<WorkoutRecords> = WorkoutRecords.fetchRequest()
        req.predicate = NSPredicate(format: "exercise == %@", exerciseEntity)
        req.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        let entities = (try? context.fetch(req)) ?? []
        return entities.map { WorkoutRecordMapper.toDomain($0) }
    }
}
