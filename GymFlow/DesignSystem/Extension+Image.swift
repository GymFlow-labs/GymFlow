//
//  Extension+Image.swift
//  GymFlow
//
//  Created by Artem Kriukov on 07.10.2025.
//

import SwiftUI

extension Image {
    static func from(_ uiImage: UIImage?) -> Image {
        if let image = uiImage {
            return Image(uiImage: image)
        } else {
            return Image(systemName: "exclamationmark.triangle")
        }
    }
    // MARK: - Training Icons
    static var barbell: Image {
        .from(R.image.barbell())
    }
    
    static var calendar: Image {
        .from(R.image.calendar())
    }
    
    static var cardio: Image {
        .from(R.image.cardio())
    }
    
    static var crossfit: Image {
        .from(R.image.crossfit())
    }
    
    static var weight: Image {
        .from(R.image.weight())
    }
    // MARK: - Common Icons
    static var chevron: Image {
        .from(R.image.chevron())
    }
}
