//
//  AddRecordView.swift
//  GymFlow
//
//  Created by Artem Kriukov on 06.10.2025.
//

import SwiftUI

struct AddRecordView: View {
    var body: some View {
        VStack {
            RowButtonView(text: "упражнение", textIcon: .barbell) {
                print("RowButtonView Action упражнение")
            }
            .padding()
            
            RowButtonView(text: "Календарь", textIcon: .calendar) {
                print("RowButtonView Action Календарь")
            }
            .padding()
        }
    }
}

#Preview {
    AddRecordView()
}

struct RowButtonView: View {
    private let text: String
    private let textIcon: Image
    private var action: () -> Void?

    init(text: String, textIcon: Image, action: @escaping () -> Void?) {
        self.text = text
        self.textIcon = textIcon
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                textIcon
                    .resizable()
                    .frame(width: 30, height: 30)

                Text(text)
                    .font(.title3)
                Spacer()
                Image.chevron
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            .foregroundStyle(Color.primaryTextColor)
            .padding()
        }
        .background(Color.cellBackgroundColor)
        .cornerRadius(12)
    }
}
