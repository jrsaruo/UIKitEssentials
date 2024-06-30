# UIKitEssentials

Essentials for development using UIKit.

## Requirements

- iOS 12.0+ / tvOS 12.0+ / visionOS 1.0+
- Swift 5.9+

## Using UIKitEssentials in your project

To use the `UIKitEssentials` library in a SwiftPM project, add the following line to the dependencies in your `Package.swift` file:

```swift
.package(url: "https://github.com/jrsaruo/UIKitEssentials", from: "1.4.0"),
```

and add `UIKitEssentials` as a dependency for your target:

```swift
.target(name: "<target>", dependencies: [
    .product(name: "UIKitEssentials", package: "UIKitEssentials"),
    // other dependencies
]),
```

Finally, add `import UIKitEssentials` in your source code.
