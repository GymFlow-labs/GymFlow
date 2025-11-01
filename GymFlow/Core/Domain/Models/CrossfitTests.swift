//
//  CrossfitTests.swift
//  GymFlow
//
//  Created by Artem Kriukov on 31.10.2025.
//

import Foundation

struct CrossfitTests {
    let nameRu: String
    let nameEn: String
    let shortDescription: String
    let description: String
    let tips: String
    let timeCap: String
    let weight: String
    let isBodyweight: Bool
    var isFavorite: Bool
    
    enum CodingKeys: String, CodingKey {
        case nameRu, nameEn
        case shortDescription = "short_description"
        case description, tips
        case timeCap = "time_cap"
        case weight, isBodyweight, isFavorite
    }
}
