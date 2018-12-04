# FWRouter

[![Contact Us](https://img.shields.io/discord/490015137181466645.svg)](https://discordapp.com/invite/RF2rWZ)
[![CI Status](https://img.shields.io/travis/JianweiWangs/FWRouter.svg?style=flat)](https://travis-ci.org/JianweiWangs/FWRouter)
[![Version](https://img.shields.io/cocoapods/v/FWRouter.svg?style=flat)](https://cocoapods.org/pods/FWRouter)
[![License](https://img.shields.io/cocoapods/l/FWRouter.svg?style=flat)](https://cocoapods.org/pods/FWRouter)
[![Platform](https://img.shields.io/cocoapods/p/FWRouter.svg?style=flat)](https://cocoapods.org/pods/FWRouter)
[![codecov](https://codecov.io/gh/JianweiWangs/FWRouter/branch/master/graph/badge.svg)](https://codecov.io/gh/JianweiWangs/FWRouter)

中文版本请查看[这里](./README_CN.md)

FWRouter is a High-performance trie-node router, idea from [Vapor/routing](https://github.com/vapor/routing)

This is not a Server router, but an iOS UI Router, You can build your own iOS app from it. 

## Example

use 
```
git clone https://github.com/JianweiWangs/FWRouter.git
cd FWRouter
make
```
to fetch and build source code quickly.

There are also some script help you develop and PR.

```make
# install dependence and open project
make

# install dependence
make install

# build test
make test

# open project
make open

# quit Xcode
make quit

```

Before you pull request, make sure test success.

## Usage

### URL Match

```Swift
let router = FWRouterManager.shared.router
// url match
route.match("scheme://host/path") { (target) -> Bool in
    let demoVC = DemoViewController()
    target.navigation?.pushViewController(demoVC, animated: true)
    return true
}
route.route(url: "scheme://host/path")
```

### Path Parameter

```Swift
router.match("scheme://host", "parameter", String.parameter, use: { (target) -> Bool in
    print(target.url) // scheme://host/parameter/param0
    print(target.pathParamters.next(String.self)) // "param0"
    return true
})
router.route(url: "scheme://host/parameter/param0")
```

### Parameter

```Swift
router.match("scheme://host/path", "/thridParameter", use: { (target) -> Bool in
    print(target.parameters["name"] as? String) //"wangjianwei"
    return true
})
router.route(
    url: "scheme://host/path/thridParameter", 
    parameters: ["name": "wangjianwei"]
)
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

