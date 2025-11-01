//
//  AddRecordView.swift
//  GymFlow
//
//  Created by Artem Kriukov on 06.10.2025.
//

import SwiftUI

enum AddResultViewType {
    case oneRepMax
    case test
}

struct AddResultView: View {
    let type: AddResultViewType
    private var selectedExercise: Exercise?
    private var selectedTest: CrossfitTests?
    
    @State private var showCalendar = false
    @State private var weight = "0"
    @State private var selectedDate: Date? = Date()
    
    // Для теста
    @State private var didPassTest = true 
    @State var minutes = ""
    @State var seconds = ""
    @State private var reps = ""
    
    // Toast
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var toastType: ToastType = .success
    
    @Environment(\.dismiss) var dismiss
    
    private let viewModel: AddResultViewModelProtocol
    
    var onSelectExercise: (@MainActor () -> Void)?
    var onSelectTest: (@MainActor () -> Void)?
    var onSave: (@MainActor () -> Void)?
    
    init(
        viewModel: AddResultViewModelProtocol,
        type: AddResultViewType,
        selectedExercise: Exercise? = nil,
        selectedTest: CrossfitTests? = nil
    ) {
        self.viewModel = viewModel
        self.type = type
        self.selectedExercise = selectedExercise
        self.selectedTest = selectedTest
        print("✅ AddResultView init called with test:", selectedTest?.nameEn ?? "nil")
    }
    
    var body: some View {
        ScrollView {
            VStack {
                
                switch type {
                case .oneRepMax:
                    SectionHeader(text: "Упражнение")
                    SelectedExerciseView(
                        selectedExercise: selectedExercise,
                        selectedTest: nil,
                        type: .oneRepMax,
                        onTap: {
                            onSelectExercise?()
                        }
                    )
                    OneRepMaxView(weight: $weight)
                case .test:
                    SectionHeader(text: "Тест")
                      SelectedExerciseView(
                          selectedExercise: nil,
                          selectedTest: selectedTest,
                          type: .test,
                          onTap: {
                              onSelectTest?()  
                          }
                      )
                      TestView(
                          didPassTest: $didPassTest,
                          minutes: $minutes,
                          seconds: $seconds,
                          reps: $reps,
                          weight: $weight
                      )
                }
                
                SectionHeader(text: "Дата")
                RowButtonView(
                    text: selectedDate.map { $0.formatted(date: .long, time: .omitted) } ?? "Выберите дату",
                    textIcon: .calendar
                ) {
                    showCalendar = true
                }
                .padding(.bottom)
                .sheet(isPresented: $showCalendar) {
                    CalendarSheet(selectedDate: $selectedDate)
                        .presentationDetents([.medium])
                }
                
                Spacer(minLength: 16)
                
                SaveButton { save() }
                .padding(.bottom)
            }
            .padding(.horizontal)
            .padding(.top)
        }
        .navigationTitle(type == .oneRepMax ? "Новый рекорд" : "Запись теста")
        .navigationBarTitleDisplayMode(.large)
        .background(Color.backgroundColor)
        .animation(.easeInOut, value: showToast)
        .hideKeyboardOnTap()
        .overlay(alignment: .top) {
            if showToast {
                ToastView(message: toastMessage, type: toastType) {
                    withAnimation(.easeInOut) { showToast = false }
                }
                .transition(.move(edge: .top).combined(with: .opacity))
                .padding(.top, 8)
            }
        }
    }
    
    private func save() {
        Task {
#warning("проверка на все заполненые поля")
            guard let exercise = selectedExercise, let date = selectedDate else {
                showError("Заполните упражнение и дату")
                return
            }
            
            switch type {
            case .oneRepMax:
                guard let weight = Double(weight) else { showError("Введите корректный вес"); return }
                do {
                    try await viewModel.addRecord(for: exercise, date: date, weight: weight)
                    showSuccess("Рекорд сохранён")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        onSave?()
                    }
                } catch { showError(error.localizedDescription) }
                
            case .test:
                print(":test")
            }
        }
    }
    
    private func showSuccess(_ msg: String) {
        toastMessage = msg
        toastType = .success
        withAnimation { showToast = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation { showToast = false }
        }
    }
    
    private func showError(_ msg: String) {
        toastMessage = msg
        toastType = .error
        withAnimation { showToast = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation { showToast = false }
        }
    }
}

// MARK: - Subviews

struct OneRepMaxView: View {
    @Binding var weight: String
    
    var body: some View {
        SectionHeader(text: "Ваш рекорд")
        WeightField(text: $weight, unit: "кг")
            .padding(.bottom)
    }
}

struct TestView: View {
    @Binding var didPassTest: Bool
    @Binding var minutes: String
    @Binding var seconds: String
    @Binding var reps: String
    @Binding var weight: String
    
    var body: some View {
        SectionHeader(text: "Выполнение теста")
        TwoCapsuleSelector(isFull: $didPassTest)
            .padding(.bottom)
        
        if didPassTest {
            SectionHeader(text: "Время прохождения")
            TimeSplitField(minutes: $minutes, seconds: $seconds)
                .padding(.bottom)
        } else {
            SectionHeader(text: "Выполненные повторения")
            WeightField(text: $reps, unit: "раз")
                .padding(.bottom)
        }
        
        SectionHeader(text: "Вес, с которым выполнялся тест")
        WeightField(text: $weight, unit: "кг")
            .padding(.bottom)
    }
}

struct SectionHeader: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.headline)
            .foregroundStyle(Color.primaryTextColor)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct TwoCapsuleSelector: View {
    @Binding var isFull: Bool
    var body: some View {
        HStack(spacing: 8) {
            SelectButton(title: "Частично", systemImage: "hourglass", isSelected: !isFull) {
                withAnimation(.spring(response: 0.25, dampingFraction: 0.9)) { isFull = false }
            }
            
            SelectButton(title: "Полностью", systemImage: "checkmark", isSelected: isFull) {
                withAnimation(.spring(response: 0.25, dampingFraction: 0.9)) { isFull = true }
            }
        }
    }
}

struct SelectButton: View {
    let title: String
    let systemImage: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: systemImage)
                Text(title)
            }
            .font(.subheadline.weight(.semibold))
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .background(
                isSelected ? Color.accentGreenColor
                    .opacity(0.18) : Color.cellBackgroundColor
            )
            .foregroundStyle(Color.primaryTextColor)
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .buttonStyle(.plain)
    }
}

struct WeightField: View {
    @Binding var text: String
    
    let unit: String
    let keyboard: UIKeyboardType = .numberPad
    
    var body: some View {
        HStack(spacing: 12) {
            TextField("0", text: $text)
                .font(.largeTitle)
                .keyboardType(keyboard)
                .foregroundStyle(Color.primaryTextColor)
                .padding()
            Text(unit)
                .font(.title3)
                .foregroundStyle(Color.secondaryTextColor)
                .padding()
        }
        .background(Color.cellBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: UIConstants.CornerRadius.large))
    }
}

struct TimeSplitField: View {
    @Binding var minutes: String
    @Binding var seconds: String
    @FocusState private var focus: Field?
    private enum Field { case mm, ss }
    
    var body: some View {
        HStack(spacing: 8) {
            TimeBoxTextField(text: $minutes, placeholder: "мм")
                .focused($focus, equals: .mm)
                .onChange(of: minutes) { new in
                    minutes = String(new.filter(\.isNumber).prefix(2))
                    if minutes.count == 2 { focus = .ss; UIImpactFeedbackGenerator(style: .light).impactOccurred() }
                }
            
            Text(":").font(.title2).foregroundStyle(Color.secondaryTextColor)
            
            TimeBoxTextField(text: $seconds, placeholder: "сс")
                .focused($focus, equals: .ss)
                .onChange(of: seconds) { new in
                    var filtered = String(new.filter(\.isNumber).prefix(2))
                    if let s = Int(filtered), s > 59 { filtered = "59" }
                    seconds = filtered
                }
        }
        .padding()
        .background(Color.cellBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: UIConstants.CornerRadius.large))
    }
}

struct TimeBoxTextField: View {
    @Binding var text: String
    
    let placeholder: String
    var body: some View {
        TextField(placeholder, text: $text)
            .keyboardType(.numberPad)
            .font(.title2)
            .multilineTextAlignment(.center)
            .frame(width: 68)
            .padding(.vertical, 6)
            .background(Color.backgroundColor.opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: 10))
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
        Button(action: action) {
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

#Preview("PR — Новый рекорд") {
    NavigationView {
        AddResultView(
            viewModel: AddResultViewModel(
                workoutRecordRepository: WorkoutRecordsRepositories(
                    coreDataStack: CoreDataStack()
                )
            ),
            type: .test,
            selectedExercise: nil
        )
    }
}

struct SelectedExerciseView: View {
    let selectedExercise: Exercise?
    let selectedTest: CrossfitTests?
    let type: AddResultViewType
    let onTap: () -> Void
    
    private var displayText: String {
        switch type {
        case .oneRepMax:
            return selectedExercise?.nameRu ?? "Выберите упражнение"
        case .test:
            return selectedTest?.nameEn ?? "Выберите тест"
        }
    }
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                Image.barbell
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color.accentColor)
                
                Text(displayText)
                    .foregroundStyle(Color.primaryTextColor)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.secondaryTextColor)
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding()
            .background(Color.cellBackgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: UIConstants.CornerRadius.large))
        }
        .buttonStyle(.plain)
        .padding(.bottom)
    }
}
