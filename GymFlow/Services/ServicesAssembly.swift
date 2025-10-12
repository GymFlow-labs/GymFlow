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
    
    private lazy var workoutService: WorkoutRecordsRepositories = {
        WorkoutRecordsRepositories(coreDataStack: coreDataStack)
    }()
#warning("Переписать network")
    private lazy var exercisesNetworkClient: NetworkClient = {
        NetworkClient()
    }()
    
    var workoutServiceImpl: WorkoutRecordsRepositories {
        workoutService
    }
    
    var exercisesNetworkClientImpl: NetworkClient {
        exercisesNetworkClient
    }
}
