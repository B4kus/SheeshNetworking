//
//  SheeshMockNetworkingConfigurationProtocol.swift
//  
//
//  Created by Szymon Szysz on 13/08/2023.
//

import Foundation

/**
 A protocol that defines configuration options for mock networking in the Sheesh framework.
 */
public protocol SheeshMockNetworkingConfigurationProtocol {
    /// The bundle containing mock data files.
    var mockBundle: Bundle { get }
    
    /// A flag indicating whether to use only mock data for requests.
    var useOnlyMock: Bool { get }
    
    /// The default file extension for mock data files.
    static var defaultMockFileExtension: String? { get }
}
