//
//  ResultScreenType.swift
//  GymFlow
//
//  Created by Artem Kriukov on 30.10.2025.
//

import Foundation

enum ResultScreenType: CaseIterable, Equatable {
    case oneRM
    case test
    
    var title: String {
        switch self {
        case .oneRM:
            return "1ПМ"
        case .test:
            return "Тесты"
        }
    }
}
