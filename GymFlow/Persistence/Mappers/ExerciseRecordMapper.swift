//
//  ExerciseRecordMapper.swift
//  GymFlow
//
//  Created by Artem Kriukov on 12.10.2025.
//

import CoreData

struct ExerciseRecordMapper {
    static func toEntity(
        weight: Double,
        date: Date,
        exerciseEntity: Exercise1RM,
        context: NSManagedObjectContext
    ) -> WorkoutRecords {
        let record = WorkoutRecords(context: context)
        record.id = UUID()
        record.weight = weight
        record.date = date
        record.exercise = exerciseEntity
        return record
    }
}
