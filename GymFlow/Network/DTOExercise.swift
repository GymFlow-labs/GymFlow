//
//  DTOExercise.swift
//  GymFlow
//
//  Created by Artem Kriukov on 09.10.2025.
//

import Foundation

struct DTOExercise: Codable {
    let id: Int
    let name: String
    let nameRu: String
    let category: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id = "exercise_id"
        case name
        case nameRu = "name_ru"
        case category, description
    }
}

