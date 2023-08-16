# 🚀 Sheesh Framework: Networking Magic 🪄

Welcome to Sheesh Framework, where networking becomes as easy as saying "Sheesh!" Our networking magic helps you manage actual and mock network requests seamlessly. Now you can focus on coding while we handle the network sorcery!

## Features

- Actual network requests with `SheeshNetworking`.
- Configurable networking behavior using `SheeshNetworkingConfigurationProtocol` and `SheeshMockNetworkingConfigurationProtocol`.
- Clean and easy-to-use protocols for defining endpoints.

## Example Usages

- Making actual requests with the coolness of SheeshNetwork.
- Testing and debugging with the help of SheeshMockNetwork.
- Having a blast with both actual and mock requests with Sheesh's dual personality!


## Get Started

Download framework using Swift Package Manager

1. Import the framework:

```swift
import SheeshNetworking
```

2. Create your awesome endpoints by conforming to the Endpoint protocol.

```swift
enum ExmapleEndpoint {
    case exmaple 
}

extension Exmaple: Endpoint {
    
    typealias Output = ExmapleOutput
    
     var path: String {
        switch self {
        case .exmaple: return "/api/example"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .exmaple: return .GET
        }
    }
    
    var queryItems: [URLQueryItem]? {
        nil
    }
    
    var httpHeaders: [String : String]? {
        [:]
    }
    
    var shouldUseMock: Bool {
        false
    }
}
```

3. Create a base configuration for your network. 

```swift
final class ExampleConfigurationProvider: SheeshNetworkingConfigurationProtocol {

    var urlSession: URLSession { URLSession.shared }
    
    var scheme: String { "https" }
    
    var host: String { "example.com" }
    
    var defaultHeaders: [String : String]? { [:] }
    
    var useOnlyMockService: Bool { false }
    
}
```

4. Initialize `SheeshNetworking` with Your configuration

```swift
let networking = SheeshNetworking(configuration: ExampleConfigurationProvider())
```

5. Make network requests with sheesh!:

```swift
let endpoint = ExmapleEndpoint.example
networking.request(endpoint)
    .sink(receiveCompletion: { completion in
        // Handle completion
    }, receiveValue: { response in
        // Handle response
    })
    .store(in: &cancellables)
```

6. You can also use mock service if needed, just provide a mock configuration `SheeshMockNetworkingConfigurationProtocol` and pass it to `SheeshNetworking` during initalization 

## Contributing

Found a bug? Got an enchanting feature idea? We'd love to have you onboard! Check out our contribution guidelines and make your mark in the Sheesh realm.

## License

This project is licensed under the MIT License.

## Pssst!

Pssst! Don't forget to say "Sheesh!" when your networking code just works like magic! ✨🪄
