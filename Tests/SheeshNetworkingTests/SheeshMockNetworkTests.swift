//
//  SheeshMockNetworkTests.swift
//  
//
//  Created by Szymon Szysz on 13/08/2023.
//

import XCTest
import Combine
@testable import SheeshNetworking

class SheeshMockNetworkTests: XCTestCase {

    // Define a mock networking configuration for testing
    struct MockConfiguration: SheeshMockNetworkingConfigurationProtocol {
        var mockBundle: Bundle {
            return Bundle.main
        }
        
        var useOnlyMock: Bool {
            return true
        }
        
        static var defaultMockFileExtension: String? {
            return "json"
        }
    }

    private var cancellables: Set<AnyCancellable>!
    
    var mockNetwork: SheeshMockNetwork!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockNetwork = SheeshMockNetwork(mockConfiguration: MockConfiguration())
        cancellables = []
    }

    override func tearDownWithError() throws {
        mockNetwork = nil
        
        try super.tearDownWithError()
    }

    func testMockNetworkRequest() throws {
        
        struct OutputTest: Decodable {
            let test: String
        }
        
        struct SUTMock: MockEndpoint {
            var plainMockJson: String? {
            """
                {
                    "test": "Szymon"
                    
                }
                
                """
            }
            
            var shouldUseMock: Bool
            
            var mockFilename: String? { "test" }
            
            var mockExtension: String? { "json" }
            
            typealias Output = OutputTest
            
            var path: String { "" }
            
            var httpMethod: HTTPMethod { .GET }
            
            var httpHeaders: [String : String]? { nil }
            
            var queryItems: [URLQueryItem]? { nil }
     
        }
        
        
        let endpoint = SUTMock(shouldUseMock: true)
        let expectation = XCTestExpectation(description: "Mock network request")
        
        mockNetwork.request(endpoint)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Request failed with error: \(error)")
                }
            }, receiveValue: { output in
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5.0)
    }
}
