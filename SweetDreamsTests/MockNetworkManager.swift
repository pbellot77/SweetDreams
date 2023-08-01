//
//  MockNetworkManager.swift
//  SweetDreamsTests
//
//  Created by Patrick Bellot on 8/1/23.
//

import Foundation
@testable import SweetDreams 

// Create a mock network manager that conforms to NetworkManagerProtocol
class MockNetworkManager: NetworkManagerProtocol {
    // Define a property to store the data to be returned during testing
    var mockData: Data?
    var mockError: Error?

  // Implement the fetchData method to return the mock data or error
    func fetchData<T: Decodable>(from url: URL) async throws -> T {
        if let mockError = mockError {
            throw mockError
        }

        guard let mockData = mockData else {
            throw NSError(domain: "MockNetworkManager", code: 1, userInfo: nil)
        }

        // Decode the mockData to the correct type T
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: mockData)
            return decodedData
        } catch {
            throw error
        }
    }
}

