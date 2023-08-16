//
//  SheeshNetworking.swift
//  
//
//  Created by Szymon Szysz on 13/08/2023.
//

import Foundation
import Combine

/**
 A class that manages network operations and provides both actual and mock networking options.
 */
public final class SheeshNetworking {
    
    // MARK: - Configuration
    
    /// The configuration for actual network requests.
    public let configuration: SheeshNetworkingConfigurationProtocol
    
    /// The configuration for mock network requests.
    public let mockConfiguration: SheeshMockNetworkingConfigurationProtocol?
    
    // MARK: - Properties
    
    private let sheeshNetwork: SheeshNetworkingProtocol
    private let sheeshMockNetwork: SheeshNetworkingProtocol
    
    // MARK: - Initialize
    
    /**
     Initializes a `SheeshNetworking` instance with the provided configurations.
     
     - Parameters:
        - configuration: The configuration for actual network requests.
        - mockConfiguration: The configuration for mock network requests.
     */
    public init(configuration: SheeshNetworkingConfigurationProtocol, mockConfiguration: SheeshMockNetworkingConfigurationProtocol? = nil) {
        self.configuration = configuration
        self.mockConfiguration = mockConfiguration
        self.sheeshNetwork = SheeshNetwork(configuration: configuration)
        self.sheeshMockNetwork = SheeshMockNetwork(mockConfiguration: mockConfiguration)
    }
    
    // MARK: - Request
    
    /**
     Performs a network request for a given endpoint, either using actual or mock networking based on configuration.
     
     - Parameter endpoint: The endpoint to request data from.
     - Returns: A publisher that emits the output data or an error.
     */
    public func request<ConcreteEndpoint: Endpoint>(_ endpoint: ConcreteEndpoint) -> AnyPublisher<ConcreteEndpoint.Output, Error> {
        
        if endpoint.shouldUseMock || configuration.useOnlyMockService {
            return sheeshMockNetwork.request(endpoint)
        } else {
            return sheeshNetwork.request(endpoint)
        }
    }
}
