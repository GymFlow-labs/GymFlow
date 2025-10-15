//
//  RowButtonView.swift
//  GymFlow
//
//  Created by Artem Kriukov on 13.10.2025.
//

import SwiftUI

struct RowButtonView: View {
    private let text: String
    private let textIcon: Image
    private let action: (() -> Void)?
    
    init(text: String, textIcon: Image, action: (() -> Void)? = nil) {
        self.text = text
        self.textIcon = textIcon
        self.action = action
    }
    
    var body: some View {
        if let action = action {
            Button(action: action) {
                content
            }
            .buttonStyle(.plain)
        } else {
            content
        }
    }
    
    private var content: some View {
        HStack {
            textIcon
                .resizable()
                .frame(width: 30, height: 30)
            
            Text(text)
                .font(.subheadline)
            Spacer()
            Image.chevron
                .resizable()
                .frame(width: 20, height: 20)
        }
        .foregroundStyle(Color.primaryTextColor)
        .padding()
        .background(Color.cellBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: UIConstants.CornerRadius.large))
    }
}
