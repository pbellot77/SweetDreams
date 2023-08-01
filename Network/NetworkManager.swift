//
//  NetworkManager.swift
//  SweetDreams
//
//  Created by Patrick Bellot on 8/1/23.
//

import Foundation

// Define a protocol for the network manager
protocol NetworkManagerProtocol {
    // Define a method to fetch data from a given URL
    func fetchData<T: Decodable>(from url: URL) async throws -> T
}

// Implement the NetworkManager class that conforms to the NetworkManagerProtocol
class NetworkManager: NetworkManagerProtocol {
    // Singleton instance to use throughout the app
    static let shared = NetworkManager()
    
    // Private initializer to prevent direct instantiation of the singleton
    private init() {}
    
    // Implement the fetchData method to make an asynchronous HTTP request
    func fetchData<T: Decodable>(from url: URL) async throws -> T {
        // Perform the actual URLSession data task and decode the response data
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}

