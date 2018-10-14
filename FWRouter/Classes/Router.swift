//
//  Router.swift
//  FWRouter
//
//  Created by Wang Jianwei on 2018/9/20.
//

public protocol Router: class {
    var routes: [Route<Action>] { get }
    func register(route: Route<Action>)
    func route(tar: Target) -> Action?
}

