//
//  NetworkService.swift
//  GymFlow
//
//  Created by Artem Kriukov on 09.10.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)
}

protocol ExercisesAPIProtocol {
    func fetchExercises() async throws -> [ExerciseDTO]
}

final class NetworkClient: ExercisesAPIProtocol {
    
    func fetchExercises() async throws -> [ExerciseDTO] {
        guard let url = URL(string: "https://gymflow-backend-3a0w.onrender.com/exercises") else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            throw NetworkError.serverError(statusCode: statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            let exercise = try decoder.decode([ExerciseDTO].self, from: data)
            return exercise
        } catch {
            throw NetworkError.decodingError
        }
    }
}
