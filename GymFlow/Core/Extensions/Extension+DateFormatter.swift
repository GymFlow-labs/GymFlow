//
//  Extension+DateFormatter.swift
//  GymFlow
//
//  Created by Artem Kriukov on 13.10.2025.
//

import Foundation

extension DateFormatter {
    static let displayFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.doesRelativeDateFormatting = true
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()
}
