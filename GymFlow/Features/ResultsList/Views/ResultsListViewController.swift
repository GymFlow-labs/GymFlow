//
//  ResultsListViewController.swift
//  GymFlow
//
//  Created by Artem Kriukov on 05.10.2025.
//

import UIKit

final class ResultsListViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: ResultsListViewModelProtocol
    private let servicesAssembly: ServicesAssembly
    private let typeScreen: ResultScreenType = .oneRM
    
    var onSelectRecord: ((Exercise) -> Void)?
    // MARK: - UI
    
    private lazy var segmentedControl: SegmentedControl = {
       let element = SegmentedControl(titles: ResultScreenType.allCases.map { $0.title })
        element.addAction(UIAction { [weak self] _ in
            guard let self else { return }
            self.changeSegment(self.segmentedControl)
        }, for: .valueChanged)
        return element
    }()
    
    private lazy var recordsTableView: UITableView = {
        let element = UITableView()
        element.dataSource = self
        element.delegate = self
        element.backgroundColor = R.color.backgroundColor()
        element.showsVerticalScrollIndicator = false
        element.separatorStyle = .none
        element.register(ResultsTableViewCell.self)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        switchMode(type: typeScreen)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    // MARK: - Init
    init(viewModel: ResultsListViewModelProtocol, servicesAssembly: ServicesAssembly) {
        self.viewModel = viewModel
        self.servicesAssembly = servicesAssembly
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func changeSegment(_ sender: UISegmentedControl) {
        let selectedMode: ResultScreenType = sender.selectedSegmentIndex == 0 ? .oneRM : .test
        switchMode(type: selectedMode)
    }
    
    private func switchMode(type: ResultScreenType) {
        navigationItem.title = type.title
        switch type {
        case .oneRM:
            print(1)
        case .test:
            print(2)
        }
    }
    
    private func setupViews() {
        view.backgroundColor = R.color.backgroundColor()
        
        view.addSubview(segmentedControl)
        view.addSubview(recordsTableView)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            recordsTableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
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

extension ResultsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ResultsTableViewCell = tableView.dequeueReusableCell()
        let model = viewModel.exercises[indexPath.row]
        cell.configure(with: model)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ResultsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        72
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let exercise = viewModel.exercises[indexPath.row]
        onSelectRecord?(exercise) 
    }
}
