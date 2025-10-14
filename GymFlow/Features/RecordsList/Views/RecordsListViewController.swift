//
//  RecordsListViewController.swift
//  GymFlow
//
//  Created by Artem Kriukov on 05.10.2025.
//

import UIKit

final class RecordsListViewController: UIViewController {
    // MARK: - Data
    private let viewModel: RecordListViewModelProtocol
    private let servicesAssembly: ServicesAssembly
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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    // MARK: - Init
    init(viewModel: RecordListViewModelProtocol, servicesAssembly: ServicesAssembly) {
        self.viewModel = viewModel
        self.servicesAssembly = servicesAssembly
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        viewModel.fetchRecords { [weak self] in
            DispatchQueue.main.async {
                self?.recordsTableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension RecordsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RecordTableViewCell = tableView.dequeueReusableCell()
        let model = viewModel.exercises[indexPath.row]
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
        let exercise = viewModel.exercises[indexPath.row]
        let workoutAssembly = WorkoutRecordDetailAssembly(serviceAssembly: servicesAssembly)
        let workoutVC = workoutAssembly.build(with: exercise)
        let nav = UINavigationController(rootViewController: workoutVC)
        nav.modalPresentationStyle = .formSheet
        present(nav, animated: true)
    }
}
