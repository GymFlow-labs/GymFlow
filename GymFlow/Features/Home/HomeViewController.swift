//
//  HomeViewController.swift
//  GymFlow
//
//  Created by Artem Kriukov on 13.10.2025.
//

import SwiftUI
import UIKit

final class HomeViewController: UIViewController {    
    private lazy var stackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 16
        element.alignment = .fill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    private func recordsButtonTapped() {

    }
    
    private func testsButtonTapped() {
        print("⏸️ testsButtonTapped")
    }
    
    private func trainingButtonTapped() {
        print("🔁 trainingButtonTapped")
    }
}

private extension HomeViewController {
    func setupViews() {
        view.backgroundColor = R.color.backgroundColor()
        
        view.addSubview(stackView)
        
        let buttons: [UIView] = [
            makeButton(title: "Рекорды", icon: .records) { [weak self] in self?.recordsButtonTapped() },
            makeButton(title: "Тесты", icon: .tests) { [weak self] in self?.testsButtonTapped() },
            makeButton(title: "Тренировки", icon: .training) { [weak self] in self?.trainingButtonTapped() }
        ]
        
        buttons.forEach { stackView.addArrangedSubview($0) }
        
        view.addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

private extension HomeViewController {
    func makeButton(title: String, icon: Image, action: @escaping () -> Void) -> UIView {
        let swiftUIButton = RowButtonView(text: title, textIcon: icon)
            .onTapGesture { action() }
        
        let hosting = UIHostingController(rootView: swiftUIButton)
        hosting.view.translatesAutoresizingMaskIntoConstraints = false
        hosting.view.backgroundColor = .clear
        
        return hosting.view
    }
}
