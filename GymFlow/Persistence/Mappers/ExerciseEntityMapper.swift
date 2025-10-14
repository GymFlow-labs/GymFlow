//
//  ExerciseEntityMapper.swift
//  GymFlow
//
//  Created by Artem Kriukov on 12.10.2025.
//

import CoreData

struct ExerciseEntityMapper {
    static func toEntity(_ exercise: Exercise, context: NSManagedObjectContext) -> Exercise1RM {
        let entity = Exercise1RM(context: context)
        entity.id = exercise.id
        entity.nameEn = exercise.name
        entity.nameRu = exercise.nameRu
        entity.descr = exercise.description
        entity.category = exercise.category
        return entity
    }

    static func toDomain(_ entity: Exercise1RM) -> Exercise {
        Exercise(
            name: entity.nameEn ?? "",
            nameRu: entity.nameRu ?? "",
            category: entity.category ?? "",
            description: entity.descr ?? "",
            id: entity.id ?? ""
        )
    }
}
