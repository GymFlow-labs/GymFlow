//
//  LoaderView.swift
//  GymFlow
//
//  Created by Artem Kriukov on 19.10.2025.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .scaleEffect(1.5)
    }
}
