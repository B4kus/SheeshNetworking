//
//  SheeshNetworkingConfigurationProtocol.swift
//  
//
//  Created by Szymon Szysz on 11/08/2023.
//

import Foundation

/**
 A protocol that defines the configuration for Sheesh network operations.
 */
public protocol SheeshNetworkingConfigurationProtocol {
    /// The URLSession instance to be used for network requests.
    var urlSession: URLSession { get }
    
    /// The URL scheme (e.g., "http", "https") for network requests.
    var scheme: String { get }
    
    /// The host of the API for network requests.
    var host: String { get }
    
    /// The default headers to be included in network requests.
    var defaultHeaders: [String: String]? { get }
    
    /// A flag indicating whether to use only mock data for requests.
    var useOnlyMockService: Bool { get }
}
