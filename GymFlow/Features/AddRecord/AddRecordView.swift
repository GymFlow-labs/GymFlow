//
//  AddRecordView.swift
//  GymFlow
//
//  Created by Artem Kriukov on 06.10.2025.
//

import SwiftUI

struct AddRecordView: View {
    @State private var showCalendar = false
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var selectedExercise: Exercise?
    @State private var weight = "1"
    @State private var selectedDate: Date?
    
    private let viewModel: AddRecordViewModelProtocol
    private let exercisesAssembly: ExercisesAssembly
    
    init(viewModel: AddRecordViewModel, exercisesAssembly: ExercisesAssembly) {
        self.viewModel = viewModel
        self.exercisesAssembly = exercisesAssembly
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: UIConstants.Spacing.large) {
                NavigationLink(
                    destination: exercisesAssembly.build(selectedExercise: $selectedExercise)
                ) {
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
                .alert("Ошибка сохранения", isPresented: $showError) {
                    Button("Ок", role: .cancel) { }
                } message: {
                    Text(errorMessage)
                }
                
                .padding(.bottom)
            }
            .padding(.horizontal)
            .navigationTitle("Новый рекорд")
            .background(Color.backgroundColor)
        }
    }
    
    private func saveRecord() {
        Task {
            if let exercise = selectedExercise,
               let doubleWeight = Double(weight),
               let date = selectedDate {
                do {
                    try await viewModel.addRecord(for: exercise, date: date, weight: doubleWeight)
                } catch {
                    errorMessage = (error as NSError).localizedDescription
                    showError = true
                }
            } else {
                errorMessage = "Заполните все поля перед сохранением."
                showError = true
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
