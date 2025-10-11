//
//  DTOExercise.swift
//  GymFlow
//
//  Created by Artem Kriukov on 09.10.2025.
//

import Foundation

struct ExerciseDTO: Codable {
    let name: String
    let nameRu: String
    let category: String
    let description: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case nameRu = "name_ru"
        case category, description
        case id = "exercise_id"
    }
}
