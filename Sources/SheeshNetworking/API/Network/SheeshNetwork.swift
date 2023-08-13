//
//  SheeshNetworking.swift
//
//  Created by Szymon Szysz on 28/07/2022.
//  Copyright © 2022 Szymon Szysz. All rights reserved.
//

import Combine
import Foundation

/**
 A class that provides network operations using the Sheesh framework.
 */
final class SheeshNetwork: SheeshNetworkingProtocol {
    
    // MARK: - Properties
    
    private let urlSession: URLSession
    
    // MARK: - Configuration
    
    /// The configuration for the Sheesh network.
    public var configuration: SheeshNetworkingConfigurationProtocol
    
    // MARK: - Initialize
    
    /**
     Initializes a `SheeshNetwork` instance with the provided configuration.
     
     - Parameter configuration: The configuration for the Sheesh network.
     */
    public init(configuration: SheeshNetworkingConfigurationProtocol) {
        self.urlSession = configuration.urlSession
        self.configuration = configuration
    }
    
    // MARK: - SheeshNetworkingProtocol Implementation
    
    internal func request<ConcreteEndpoint: Endpoint>(_ endpoint: ConcreteEndpoint) -> AnyPublisher<ConcreteEndpoint.Output, Error> {
        guard let request = requestBuilder(endpoint) else {
            return Fail(error: NetworkStackError.invalidRequest).eraseToAnyPublisher()
        }
        
        return urlSession
            .dataTaskPublisher(for: request)
            .tryMap(\.data)
            .decode(type: ConcreteEndpoint.Output.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private func requestBuilder(_ endpoint: any Endpoint) -> URLRequest? {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = configuration.scheme
        urlComponents.host = configuration.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems
        guard let url = urlComponents.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.rawValue
        
        let headers = configuration.defaultHeaders?
            .merging(endpoint.httpHeaders ?? [:], uniquingKeysWith: { _, new in new })
        
        if let httpHeaders = headers {
            for (key, value) in httpHeaders {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
}
