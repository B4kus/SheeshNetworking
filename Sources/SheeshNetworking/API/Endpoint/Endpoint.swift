//
//  Endpoint.swift
//
//  Created by Szymon Szysz on 20/04/2020.
//  Copyright © 2020 Szymon Szysz. All rights reserved.
//

import Foundation

/**
 Represents an API endpoint configuration.
 */
public protocol Endpoint {
    /// The type of the expected output from this endpoint, conforming to Decodable.
    associatedtype Output: Decodable
    
    /// The path component of the URL for this endpoint.
    var path: String { get }
    
    /// The HTTP method to be used for this endpoint (e.g., GET, POST, PUT, DELETE).
    var httpMethod: HTTPMethod { get }
    
    /// The HTTP headers to be included in the request for this endpoint.
    var httpHeaders: [String: String]? { get }
    
    /// The query items to be included in the URL for this endpoint.
    var queryItems: [URLQueryItem]? { get }
    
    /// A flag indicating whether mock data should be used for testing purposes.
    var shouldUseMock: Bool { get }
}
