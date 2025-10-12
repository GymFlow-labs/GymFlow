//
//  Exercise.swift
//  GymFlow
//
//  Created by Artem Kriukov on 11.10.2025.
//

import Foundation

struct Exercise: Hashable {
    let name: String
    let nameRu: String
    let category: String
    let description: String
    let id: String
    
    init(name: String, nameRu: String, category: String, description: String, id: String) {
        self.name = name
        self.nameRu = nameRu
        self.category = category
        self.description = description
        self.id = id
    }
    
    init(from dto: ExerciseDTO) {
        self.name = dto.name
        self.nameRu = dto.nameRu
        self.category = dto.category
        self.description = dto.description
        self.id = dto.id
    }
}
