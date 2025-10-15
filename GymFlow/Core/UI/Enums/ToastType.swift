//
//  ToastType.swift
//  GymFlow
//
//  Created by Artem Kriukov on 15.10.2025.
//

import SwiftUI

enum ToastType {
    case success
    case error
    
    var bgColor: Color {
        switch self {
        case .success:
            return Color.accentGreenColor
        case .error:
            return Color.accentRedColor
        }
    }
}
