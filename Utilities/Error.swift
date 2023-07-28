//
//  Error.swift
//  SweetDreams
//
//  Created by Patrick Bellot on 7/27/23.
//

import Foundation

// Custom API Errors
enum APIError: Error, LocalizedError {
    case unknown
    case invalidResponse
    case urlNotValid
    case noData
    
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .invalidResponse:
            return "Invalid response"
        case .urlNotValid:
            return "URL not valid"
        case .noData:
          return "There is no data"
        }
    }
}
