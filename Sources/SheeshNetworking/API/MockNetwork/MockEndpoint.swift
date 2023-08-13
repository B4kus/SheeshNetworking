//
//  MockEndpoint.swift
//  CocktailBar
//
//  Created by Szymon Szysz on 20/04/2020.
//  Copyright © 2020 Szymon Szysz. All rights reserved.
//

import Foundation

/**
 A protocol representing an API endpoint configuration that supports using mock data for testing.
 */
public protocol MockEndpoint: Endpoint {
    /// The name of the mock data file (without extension) to be used for this endpoint.
    var mockFilename: String? { get }
    
    /// The file extension of the mock data file (e.g., "json", "xml").
    var mockExtension: String? { get }
    
    var plainMockJson: String? { get }
}
