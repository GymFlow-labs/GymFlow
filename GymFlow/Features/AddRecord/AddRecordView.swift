//
//  AddRecordView.swift
//  GymFlow
//
//  Created by Artem Kriukov on 06.10.2025.
//

import SwiftUI

struct AddRecordView: View {
    @State private var showCalendar = false
    @State private var selectedExercise: Exercise?
    @State private var weight = "0"
    @State private var selectedDate: Date?
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var toastType: ToastType = .success
    
    private let viewModel: AddRecordViewModelProtocol
    private let onSelectExercise: ( (Binding<Exercise?>) -> Void)?
    
    init(
        viewModel: AddRecordViewModelProtocol,
        onSelectExercise: ((Binding<Exercise?>) -> Void)? = nil
    ) {
        self.viewModel = viewModel
        self.onSelectExercise = onSelectExercise
    }
    
    var body: some View {
        VStack(spacing: UIConstants.Spacing.large) {
            Button {
                onSelectExercise?( $selectedExercise )
            } label: {
                RowButtonView(
                    text: selectedExercise?.nameRu ?? "Выберите упражнение",
                    textIcon: .barbell
                )
            }
            .padding(.top)
            
            TextFieldView(weight: $weight)
            
            RowButtonView(
                text: selectedDate.map {
                    $0.formatted(date: .long, time: .omitted)
                } ?? "Выберите дату",
                textIcon: .calendar
            ) {
                showCalendar = true
            }
            .sheet(isPresented: $showCalendar) {
                CalendarSheet(selectedDate: $selectedDate)
                    .presentationDetents([.medium])
            }
            
            Spacer()
            
            SaveButton {
                saveRecord()
            }
            .padding(.bottom)
        }
        .padding(.horizontal)
        .navigationTitle("Новый рекорд")
        .navigationBarTitleDisplayMode(.large)
        .background(Color.backgroundColor)
        .overlay(alignment: .top) {
            if showToast {
                ToastView(message: toastMessage, type: toastType) {
                    withAnimation(.easeInOut) { showToast = false }
                }
                .transition(.move(edge: .top).combined(with: .opacity))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.easeInOut) { showToast = false }
                    }
                }
            }
        }
        .animation(.easeInOut, value: showToast)
        
    }
    
    private func saveRecord() {
        Task {
            if let exercise = selectedExercise,
               let doubleWeight = Double(weight),
               let date = selectedDate {
                do {
                    try await viewModel.addRecord(for: exercise, date: date, weight: doubleWeight)
                    toastMessage = "Рекорд сохранён"
                    toastType = .success
                    withAnimation { showToast = true }
                } catch {
                    toastMessage = (error as NSError).localizedDescription
                    toastType = .error
                    withAnimation { showToast = true }
                }
            } else {
                toastMessage = "Заполните все поля перед сохранением."
                toastType = .error
                withAnimation { showToast = true }
            }
        }
    }
}

struct CalendarSheet: View {
    @Binding var selectedDate: Date?
    @Environment(\.dismiss) var dismiss
    @State private var tempDate = Date()
    
    var body: some View {
        VStack {
            DatePicker(
                "Выберите дату",
                selection: $tempDate,
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)
            .padding()
            
            Button("Готово") {
                selectedDate = tempDate
                dismiss()
            }
            .padding()
        }
        .onAppear {
            if let selectedDate {
                tempDate = selectedDate
            }
        }
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
                .keyboardType(.numberPad)
            
            Text(unit)
                .font(.title2)
                .foregroundStyle(Color.secondaryTextColor)
        }
        .padding()
        .background(Color.cellBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: UIConstants.CornerRadius.large))
    }
}
