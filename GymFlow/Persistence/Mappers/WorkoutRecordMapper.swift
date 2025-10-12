//
//  WorkoutRecordMapper.swift
//  GymFlow
//
//  Created by Artem Kriukov on 12.10.2025.
//

import Foundation

struct WorkoutRecordMapper {
    static func toDomain(_ entity: WorkoutRecords) -> WorkoutRecord {
        guard let id = entity.id,
              let date = entity.date else {
            fatalError("Invalid WorkoutRecords entity")
        }
        
        return WorkoutRecord(
            id: id,
            date: date,
            weight: entity.weight
        )
    }
}
