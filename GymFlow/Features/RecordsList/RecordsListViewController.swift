//
//  RecordsListViewController.swift
//  GymFlow
//
//  Created by Artem Kriukov on 05.10.2025.
//

import UIKit

import Foundation

struct RecordViewItem {
    let title: String
    let date: Date
    let valueText: String
}

final class RecordsListViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var recordsTableView: UITableView = {
        let element = UITableView()
        element.dataSource = self
        element.delegate = self
        element.backgroundColor = R.color.backgroundColor()
        element.showsVerticalScrollIndicator = false
        element.separatorStyle = .none
        element.register(RecordTableViewCell.self)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    // MARK: - Data
    
    private var items: [RecordViewItem] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadData()
    }
    // MARK: - Private Methods
    
    private func setupViews() {
        view.backgroundColor = R.color.backgroundColor()
        view.addSubview(recordsTableView)
        
        NSLayoutConstraint.activate([
            recordsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            recordsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recordsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recordsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadData() {
        items = [
            RecordViewItem(title: "Жим лёжа", date: Date(), valueText: "100 кг "),
            RecordViewItem(title: "Присед", date: Date().addingTimeInterval(-86400), valueText: "140 кг"),
            RecordViewItem(title: "Тяга", date: Date().addingTimeInterval(-3*86400), valueText: "160 кг")
        ]
    }
}

// MARK: - UITableViewDataSource

extension RecordsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RecordTableViewCell = tableView.dequeueReusableCell()
        let model = items[indexPath.row]
        cell.configure(with: model)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension RecordsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        72
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Хэндлер перехода/подробностей при необходимости
    }
}
