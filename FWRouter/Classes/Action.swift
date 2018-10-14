//
//  Resolution.swift
//  FWRouter
//
//  Created by Wang Jianwei on 2018/10/13.
//

public protocol Action {
    func resolve(to int: Target) -> Bool
}

public struct BasicAction: Action {
    private let closure: (Target) -> Bool
    public init(closure: @escaping (Target) -> Bool) {
        self.closure = closure
    }
    
    public func resolve(to tar: Target) -> Bool {
        return closure(tar)
    }
}
