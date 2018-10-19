# FWRouter

[![CI Status](https://img.shields.io/travis/JianweiWangs/FWRouter.svg?style=flat)](https://travis-ci.org/JianweiWangs/FWRouter)
[![Version](https://img.shields.io/cocoapods/v/FWRouter.svg?style=flat)](https://cocoapods.org/pods/FWRouter)
[![License](https://img.shields.io/cocoapods/l/FWRouter.svg?style=flat)](https://cocoapods.org/pods/FWRouter)
[![Platform](https://img.shields.io/cocoapods/p/FWRouter.svg?style=flat)](https://cocoapods.org/pods/FWRouter)
[![codecov](https://codecov.io/gh/JianweiWangs/FWRouter/branch/master/graph/badge.svg)](https://codecov.io/gh/JianweiWangs/FWRouter)


FWRouter 是一个高性能的字典树路由，灵感来自于 [Vapor/routing](https://github.com/vapor/routing)。

这并非是一个服务端路由，你可以通过它简单的构建自定义的 iOS 应用。

## 示例

通过 
`
git clone https://github.com/JianweiWangs/FWRouter.git
&& cd FWRouter
&& make
`
命令，快速开始查看源码及使用样例代码。

这里有一些脚本能够辅助开发以及向仓库发起 PR。

```make
# 拉取全部依赖并自动打开工程
make

# 拉取依赖
make install

# 单元测试
make test

# 打开工程
make open

# 退出 Xcode
make quit

```

 请在 PR 发起前确保单元测试能够通过，并保证单元测试的覆盖率不会降低。

## 使用

### URL 匹配

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

### 路径参数获取

```Swift
router.match("scheme://host", "parameter", String.parameter, use: { (target) -> Bool in
    print(target.url) // scheme://host/parameter/param0
    print(target.pathParamters.next(String.self)) // "param0"
    return true
})
router.route(url: "scheme://host/parameter/param0")
```

### 传递额外的参数

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

## 环境

该仓库需要 `iOS 8.0+`, `Xcode 9.0+` 以及 `Swift 4.0+`.

## 依赖

FWRouter 支持 [CocoaPods](https://cocoapods.org). 
在 Podfile 中添加如下代码进行依赖

```ruby
pod 'FWRouter'
```

## 作者

JianweiWangs, wangjianwei.sir@gmail.com

## 证书

FWRouter 使用 MIT 证书. 查看 LICENSE 文件获取更多详情.

