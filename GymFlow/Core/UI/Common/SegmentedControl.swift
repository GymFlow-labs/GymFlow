//
//  SegmentedControl.swift
//  GymFlow
//
//  Created by Artem Kriukov on 30.10.2025.
//

import UIKit

final class SegmentedControl: UISegmentedControl {
    private var titles: [String]
    
    init(titles: [String]) {
        self.titles = titles
        super.init(frame: .zero)
        setupTitles()
        configureSegmentedControl()
    }

    required init?(coder: NSCoder) {
        self.titles = []
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTitles() {
        for (index, title) in titles.enumerated() {
            insertSegment(withTitle: title, at: index, animated: false)
        }
    }
    
    private func configureSegmentedControl() {
        selectedSegmentIndex = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
