//
//  WorkoutRecordDetail.swift
//  GymFlow
//
//  Created by Artem Kriukov on 14.10.2025.
//

import UIKit

final class WorkoutRecordDetailViewController: UIViewController {
    private let exercise: Exercise
    private let viewModel: WorkoutRecordDetailViewModelProtocol
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
    init(exercise: Exercise, viewModel: WorkoutRecordDetailViewModelProtocol) {
        self.exercise = exercise
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        loadRecords()
    }

    private func loadRecords() {
        let exerciseID = exercise.id
        viewModel.fetchWorkoutRecords(for: exerciseID) {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
}

extension WorkoutRecordDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel.workoutRecord.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell: RecordDetailCell = tableView.dequeueReusableCell()
        let data = viewModel.workoutRecord[indexPath.row]
        cell.configure(with: data)
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: nil) { [weak self] _, _, done in
            guard let self else { return }
            
            Task { @MainActor in
                do {
                    try await self.viewModel.deleteRecord(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                    self.showSwiftUIToast(message: "Запись удалена", type: .success, fromBottom: true)
                    
                    if self.viewModel.workoutRecord.isEmpty {
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                    done(true)
                } catch {
                    tableView.reloadRows(at: [indexPath], with: .none)
                    done(false)
                }
            }
        }
        delete.image = R.image.trashbin()
        delete.backgroundColor = .systemRed

        let config = UISwipeActionsConfiguration(actions: [delete])
        config.performsFirstActionWithFullSwipe = true

        return config
    }
}

private extension WorkoutRecordDetailViewController {
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
