# MyNetworkingKit

This repository demonstrates how to perform networking operations using the Combine framework in Swift.

## Requirements

- iOS 13.0 or later
- Xcode 12.0 or later
- Swift 5.0 or later

## Installation
There are two ways to use MyNetworkingKit in your project:
- using Swift Package Manager
- manual install (build frameworks or embed Xcode Project)

### Swift Package Manager

To integrate MyNetworkingKit into your Xcode project using Swift Package Manager, add it to the dependencies value of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/Datta-B/MyNetworkingKit.git", .upToNextMajor(from: "1.0.0"))
]
```

[Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

### Manually

If you prefer not to use Swift Package Manager, you can integrate MyNetworkingKit into your project manually.

---

## Usage

### Quick Start

```swift

import UIKit
import Combine
import MyNetworkingKit

struct sampleStruct : Codable {
    let userId : Int
    let id     : Int
    let title  : String
    let body   : String
}
class ViewController: UIViewController {

    var cancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeRequest()
    }

    private func makeRequest() {
        let urlString = "https://jsonplaceholder.typicode.com"
        guard let url = URL(string: urlString) else {return}
        let builder = RequestBuilder(baseURl: url, path: "/posts")
        builder.set(method: .get)
        builder.set(headers: ["Content-Type": "application/json"])
        
        do {
            let _ = try MyNetworkManager.NetworkManger.fetchRequest(with: builder, type: [sampleStruct].self)
                .sink { completion in
                    switch completion {
                    case .finished :
                        print("finished")
                    case .failure(let error) :
                        print("print error \(error)")
                    }
                } receiveValue: { response in
                    print(response)
                }.store(in: &cancellable)

        } catch {
            // Handle the error
        }
    }
}
```
