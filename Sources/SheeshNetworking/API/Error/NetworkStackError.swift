//
//  NetworkStackError.swift
//  CocktailBar
//
//  Created by Szymon Szysz on 20/04/2020.
//  Copyright © 2020 Szymon Szysz. All rights reserved.
//

import Foundation

/**
 Errors related to network operations and the network stack.
 */
public enum NetworkStackError: Error {
    /// The request being made is invalid.
    case invalidRequest
    
    /// The mock service configuration is missing, and mock data cannot be retrieved.
    case missingMockServiceConfiguration
    
    /// The mock path is missing in the mock service configuration.
    case missingMockPath
    
    /// Mock data is missing for the specified mock path.
    case missingMockData
    
    /// An error occurred while handling the response from the server.
    case responseError(underlyingError: Error)
    
    /**
     A user-friendly error message describing the error case.
     
     - Returns: A descriptive error message for the specific error case.
     */
    public var errorMessage: String {
        switch self {
        case .invalidRequest: return "Invalid request"
        case .missingMockServiceConfiguration: return "Mock service not configured"
        case .missingMockPath: return "No mock path"
        case .missingMockData: return "Mock data missing"
        case .responseError(let error): return "Response error: \(error.localizedDescription)"
        }
    }
}
