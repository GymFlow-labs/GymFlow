//
//  RecordsListViewModel.swift
//  GymFlow
//
//  Created by Artem Kriukov on 14.10.2025.
//

import Foundation

protocol ResultsListViewModelProtocol {
    func fetchRecords(completion: @escaping () -> Void)
    var exercises: [Exercise] { get }
}

final class RecordsListViewModel: ResultsListViewModelProtocol {
    private var exercise1RMRepositories: Exercise1RMProtocol
    private(set) var exercises: [Exercise] = []
    
    init(exercise1RMRepositories: Exercise1RMProtocol) {
        self.exercise1RMRepositories = exercise1RMRepositories
    }
    
    func fetchRecords(completion: @escaping () -> Void) {
        let fetched = exercise1RMRepositories.fetchAll()
        self.exercises = fetched
        completion()
    }
}
