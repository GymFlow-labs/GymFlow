//
//  ServicesAssembly.swift
//  GymFlow
//
//  Created by Artem Kriukov on 12.10.2025.
//

import Foundation

final class ServicesAssembly {
    let networkClient: NetworkClient
    let coreDataStack: CoreDataStack
    
    init(networkClient: NetworkClient, coreDataStack: CoreDataStack) {
        self.networkClient = networkClient
        self.coreDataStack = coreDataStack
    }
    
    private lazy var exercise1RMRepositories: Exercise1RMProtocol = {
        Exercise1RMRepositories(coreDataStack: coreDataStack)
    }()
    
    private lazy var workoutService: WorkoutRecordRepositoryProtocol = {
        WorkoutRecordsRepositories(coreDataStack: coreDataStack)
    }()

    private lazy var exercisesNetworkClient: ExercisesAPIProtocol = {
        NetworkClient()
    }()
    
    var workoutServiceImpl: WorkoutRecordRepositoryProtocol {
        workoutService
    }
    
    var exercisesNetworkClientImpl: ExercisesAPIProtocol {
        exercisesNetworkClient
    }
    
    var exercise1RMRepositoriesImpl: Exercise1RMProtocol {
        exercise1RMRepositories
    }
}
