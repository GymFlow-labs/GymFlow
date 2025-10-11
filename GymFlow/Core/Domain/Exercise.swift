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
    
    init(from dto: ExerciseDTO) {
        self.name = dto.name
        self.nameRu = dto.nameRu
        self.category = dto.category
        self.description = dto.description
        self.id = dto.id
    }
}
