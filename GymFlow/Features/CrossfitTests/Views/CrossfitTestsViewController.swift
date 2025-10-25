//
//  CrossfitTestsViewController.swift
//  GymFlow
//
//  Created by Artem Kriukov on 25.10.2025.
//

import UIKit

// MARK: - Model
struct CrossfitTest {
    let id: String
    let name: String
    let description: String
    var isFavorite: Bool
}

final class CrossfitTestsViewController: UIViewController {
    
    // MARK: - Properties
    private var tests: [CrossfitTest] = []
    var onTestSelected: ((CrossfitTest) -> Void)?
    
    // MARK: - UI
    private lazy var searchController: UISearchController = {
        let element = UISearchController(searchResultsController: nil)
        element.searchResultsUpdater = self
        element.obscuresBackgroundDuringPresentation = false
        element.searchBar.placeholder = "Поиск"
        return element
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = CollectionViewLayoutFactory.makeVerticalListLayout(
            estimatedHeight: 150,
            interItemSpacing: 16
        )
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = R.color.backgroundColor()
        collection.delegate = self
        collection.dataSource = self
        collection.register(CrossfitTestCell.self)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        loadMockData()
    }
    
    // MARK: - Private Methods
    private func loadMockData() {
        tests = [
            CrossfitTest(
                id: "1",
                name: "TEST 1: Cindy",
                description: "AMRAP 20 минут: 5 отжманий, 10\n15 подтуняний",
                isFavorite: true
            ),
            CrossfitTest(
                id: "2",
                name: "TEST 2: Fran",
                description: "AMRAP 20 отиманий, 10\n15 подтуняний",
                isFavorite: true
            ),
            CrossfitTest(
                id: "3",
                name: "TEST 2: Murph",
                description: "",
                isFavorite: true
            ),
            CrossfitTest(
                id: "4",
                name: "TEST 2: Fran",
                description: "21-15-9: Трастеры, Подтуянания21-15-9: Трастеры, 21-15-9: Трастеры, ПодтуянанияПодтуянания21-15-9: Трастеры, Подтуянания",
                isFavorite: true
            )
        ]
        collectionView.reloadData()
    }
    
    func toggleFavorite(at indexPath: IndexPath) {
        tests[indexPath.item].isFavorite.toggle()
        collectionView.reloadItems(at: [indexPath])
    }
    
    func showInfo(for test: CrossfitTest) {
        print("ℹ️ Info tapped for: \(test.name)")
    }

}

// MARK: - Setup
private extension CrossfitTestsViewController {
    func setupViews() {
        title = "Кроссфит тесты"
        view.backgroundColor = R.color.backgroundColor()
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension CrossfitTestsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CrossfitTestCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        
        let test = tests[indexPath.item]
        cell.configure(with: test)
        cell.onFavoriteTap = { [weak self] in
            self?.toggleFavorite(at: indexPath)
        }
        cell.onInfoTap = { [weak self] in
            self?.showInfo(for: test)
        }
        cell.onAddTap = { [weak self] in
            self?.onTestSelected?(test)
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CrossfitTestsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let test = tests[indexPath.item]
        onTestSelected?(test)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CrossfitTestsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.bounds.width - 32
        return CGSize(width: width, height: 150)
    }
}

// MARK: - UISearchResultsUpdating
extension CrossfitTestsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            return
        }
        // Фильтрация тестов
    }
}
