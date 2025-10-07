//
//  AddRecordView.swift
//  GymFlow
//
//  Created by Artem Kriukov on 06.10.2025.
//

import SwiftUI

struct AddRecordView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: RecordHistoryView()) {
                    RowButtonView(text: "упражнение", textIcon: .barbell)
                }
                
                .padding()
                
                RowButtonView(text: "Календарь", textIcon: .calendar)
                .padding()
            }
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
        .cornerRadius(12)
    }
        
}
