//
//  AddRecordView.swift
//  GymFlow
//
//  Created by Artem Kriukov on 06.10.2025.
//

import SwiftUI

struct AddRecordView: View {
    @State private var weight = "1"
    
    var body: some View {
        NavigationStack {
            VStack(spacing: UIConstants.Spacing.large) {
                NavigationLink(destination: RecordHistoryView()) {
                    RowButtonView(text: "упражнение", textIcon: .barbell)
                }
                .padding(.top)
                .padding(.horizontal)
                
                TextFieldView(weight: $weight)
                    .padding(.horizontal)
                
                RowButtonView(text: "Календарь", textIcon: .calendar)
                    .padding(.horizontal)
                
                Spacer()
                
                SaveButton {
                    print(weight)
                }
                    .padding(.horizontal)
                    .padding(.bottom)
            }
            .navigationTitle("Новый рекорд")
            .background(Color.backgroundColor)
        }
    }
}

#Preview {
    AddRecordView()
}

struct RowButtonView: View {
    private let text: String
    private let textIcon: Image
    
    init(text: String, textIcon: Image) {
        self.text = text
        self.textIcon = textIcon
    }
    
    var body: some View {
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
        .background(Color.cellBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: UIConstants.CornerRadius.large))
    }
    
}

struct SaveButton: View {
    private var action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text("Сохранить")
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(Color.buttonBackgroundColor)
                .foregroundStyle(Color.buttonTextColor)
                .clipShape(RoundedRectangle(cornerRadius: UIConstants.CornerRadius.large))
        }
        .buttonStyle(.plain)
    }
}

struct TextFieldView: View {
    @Binding var weight: String
    @State private var unit = "кг"
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            TextField("Рекордный вес", text: $weight)
                .font(.largeTitle)
                .foregroundStyle(Color.primaryTextColor)
                .keyboardType(.decimalPad)
            
            Text(unit)
                .font(.title2)
                .foregroundStyle(Color.secondaryTextColor)
        }
        .padding()
        .background(Color.cellBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: UIConstants.CornerRadius.large))
    }
}
