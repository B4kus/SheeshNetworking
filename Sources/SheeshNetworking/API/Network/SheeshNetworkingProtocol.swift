//
//  SheeshNetworkingProtocol.swift
//  
//
//  Created by Szymon Szysz on 06/08/2023.
//

import Foundation
import Combine

/**
 A protocol that defines the interface for network operations using the Sheesh framework.
 */
internal protocol SheeshNetworkingProtocol {
    
    /**
     Performs a network request for a given endpoint.
     
     - Parameter endpoint: The endpoint to request data from.
     - Returns: A publisher that emits the output data or an error.
     */
    func request<ConcreteEndpoint: Endpoint>(_ endpoint: ConcreteEndpoint) -> AnyPublisher<ConcreteEndpoint.Output, Error>
}

