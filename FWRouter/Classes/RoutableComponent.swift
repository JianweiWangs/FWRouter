//
//  RoutableComponent.swift
//  FWRouter
//
//  Created by Wang Jianwei on 2018/10/13.
//

public protocol RoutableComponent {
    
    var routerParameterValue: String { get }
    
    func routerCompare(to value: String) -> Bool
}

extension String: RoutableComponent {
    public var routerParameterValue: String { return self}
    public func routerCompare(to value: String) -> Bool {
        return self == value
    }
}
