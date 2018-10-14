# FWRouter

[![CI Status](https://img.shields.io/travis/JianweiWangs/FWRouter.svg?style=flat)](https://travis-ci.org/JianweiWangs/FWRouter)
[![Version](https://img.shields.io/cocoapods/v/FWRouter.svg?style=flat)](https://cocoapods.org/pods/FWRouter)
[![License](https://img.shields.io/cocoapods/l/FWRouter.svg?style=flat)](https://cocoapods.org/pods/FWRouter)
[![Platform](https://img.shields.io/cocoapods/p/FWRouter.svg?style=flat)](https://cocoapods.org/pods/FWRouter)
[![codecov](https://codecov.io/gh/JianweiWangs/FWRouter/branch/master/graph/badge.svg)](https://codecov.io/gh/JianweiWangs/FWRouter)

FWRouter is a High-performance trie-node router, idea from [Vapor/routing](https://github.com/vapor/routing)

This is not a Server router, but a iOS UI Router, You can build your own iOS app from it. 

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```Swift
let router = FWRouterManager.shared.router
route.match("scheme://host/path") { (target) -> Bool in
    let demoVC = DemoViewController()
    target.navigation?.pushViewController(demoVC, animated: true)
    return true
}
route.route(url: "scheme://host/path")
```

## Requirements

This library requires `iOS 8.0+`, `Xcode 9.0+` and `Swift 4.0+`.

## Installation

FWRouter is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'FWRouter'
```

## Author

JianweiWangs, wangjianwei.sir@gmail.com

## License

FWRouter is available under the MIT license. See the LICENSE file for more info.

