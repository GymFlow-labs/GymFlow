//
//  WorkoutRecordDetail.swift
//  GymFlow
//
//  Created by Artem Kriukov on 14.10.2025.
//

import UIKit

struct WorkoutRecordItem {
    let date: Date
    let weight: Double
    let unit: String
}

final class WorkoutRecordDetail: UIViewController {
    private var items: [WorkoutRecordItem] = []
    // MARK: - UI
    private lazy var tableView: UITableView = {
        let element = UITableView()
        element.dataSource = self
        element.delegate = self
        element.backgroundColor = R.color.backgroundColor()
        element.separatorStyle = .none
        element.showsVerticalScrollIndicator = false
        element.translatesAutoresizingMaskIntoConstraints = false
        element.register(RecordDetailCell.self)
        return element
    }()
    
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        loadMockData()
    }
    
    func loadMockData() {
        var mock: [WorkoutRecordItem] = []
        let now = Date()
        for i in 0..<10 {
            let date = Calendar.current.date(byAdding: .day, value: -i * 3, to: now) ?? now
            // Небольшой разброс веса вокруг 100
            let weight = 100.0 + Double(Int.random(in: -10...15))
            mock.append(WorkoutRecordItem(date: date, weight: weight, unit: "кг"))
        }
        // От нового к старому
        items = mock.sorted(by: { $0.date > $1.date })
        tableView.reloadData()
    }
}

extension WorkoutRecordDetail: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RecordDetailCell = tableView.dequeueReusableCell()
        let data = items[indexPath.row]
        cell.configure(with: data)
        return cell
    }
}

private extension WorkoutRecordDetail {
    func setupLayout() {
        view.backgroundColor = R.color.backgroundColor()
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
