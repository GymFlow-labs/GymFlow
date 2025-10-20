//
//  Coordinator.swift
//  GymFlow
//
//  Created by Artem Kriukov on 19.10.2025.
//

import UIKit

typealias CoordinatorHandler = () -> Void

protocol Coordinator: AnyObject {
    var completionHandler: CoordinatorHandler? { get set }
    
    func start()
}
