//
//  ToastView.swift
//  GymFlow
//
//  Created by Artem Kriukov on 15.10.2025.
//

import SwiftUI

struct ToastView: View {
    let message: String
    let type: ToastType
    let onClose: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Text(message)
                .foregroundStyle(.white)
                .font(.subheadline)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            Button {
                onClose()
            } label: {
                Image(systemName: "xmark")
                    .foregroundStyle(.white)
                    .font(.body.weight(.semibold))
                    .padding(6)
                    .background(.white.opacity(0.15))
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 14)
        .background(
            RoundedRectangle(
                cornerRadius: UIConstants.CornerRadius.medium,
                style: .continuous
            )
                .fill(type.bgColor)
        )
        .shadow(radius: 8)
        .padding(.horizontal)
        .padding(.top, 8)
    }
}
