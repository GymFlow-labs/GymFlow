//
//  WorkoutRecordsStore.swift
//  GymFlow
//
//  Created by Artem Kriukov on 12.10.2025.
//

import CoreData
import Foundation

final class WorkoutRecordsRepositories {
    static let shared = WorkoutRecordsRepositories()
    private init() {}
    
    private let context = CoreDataStack.shared.context
    
    func addRecord(for exercise: Exercise, date: Date, weight: Double) {
        context.perform {
            do {
                let exerciseEntity: Exercise1RM
                if let existing = try Exercise1RMRepositories.fetch(by: exercise.id, in: self.context) {
                    exerciseEntity = existing
                } else {
                    exerciseEntity = ExerciseEntityMapper.toEntity(exercise, context: self.context)
                }
                
                let record = ExerciseRecordMapper.toEntity(
                    weight: weight,
                    date: date,
                    exerciseEntity: exerciseEntity,
                    context: self.context
                )
                
                try self.context.save()
                print("Record saved for exercise:", exercise.name)
            } catch {
                self.context.rollback()
                print("addRecord error:", error)
            }
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
