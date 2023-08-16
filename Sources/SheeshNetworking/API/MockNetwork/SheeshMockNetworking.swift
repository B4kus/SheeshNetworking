//
//  MockNetworking.swift
//  
//
//  Created by Szymon Szysz on 11/08/2023.
//

import Foundation
import Combine

/**
 A class that provides a mock implementation of the `SheeshNetworkingProtocol` for testing purposes.
 */
final class SheeshMockNetwork: SheeshNetworkingProtocol {
    
    /// The configuration for the Sheesh Mock network.
    public let mockConfiguration: SheeshMockNetworkingConfigurationProtocol?
    
    /**
     Initializes a `SheeshMockNetwork` instance with the provided mock configuration.
     
     - Parameter mockConfiguration: The mock configuration to be used for testing.
     */
    public init(mockConfiguration: SheeshMockNetworkingConfigurationProtocol?) {
        self.mockConfiguration = mockConfiguration
    }
    
    /**
     Requests data from a mock endpoint conforming to `MockEndpoint`.
     
     - Parameter endpoint: The mock endpoint configuration.
     - Returns: A publisher that emits the output data or an error.
     */
    internal func request<ConcreteEndpoint: Endpoint>(_ endpoint: ConcreteEndpoint) -> AnyPublisher<ConcreteEndpoint.Output, Error> {
        
        guard let mockConfiguration = mockConfiguration else {
            return Fail(error: NetworkStackError.missingMockServiceConfiguration)
                .eraseToAnyPublisher()
        }
        
        guard let endpoint = endpoint as? (any MockEndpoint) else {
            return Fail(error: NetworkStackError.missingMockServiceConfiguration)
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
        
        if let plainMockString = endpoint.plainMockJson, let data = plainMockString.data(using: .utf8) {
            return Just(data)
                .decode(type: ConcreteEndpoint.Output.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        } else {
            guard let dataURL = mockConfiguration.mockBundle.url(forResource: endpoint.mockFilename, withExtension: endpoint.mockExtension),
                  let mockData = try? Data(contentsOf: dataURL) else {
                return Fail(error: NetworkStackError.missingMockData)
                    .receive(on: DispatchQueue.main)
                    .eraseToAnyPublisher()
            }
            
            return Just(mockData)
                .decode(type: ConcreteEndpoint.Output.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
    }
}
