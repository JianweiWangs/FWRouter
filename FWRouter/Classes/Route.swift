//
//  Route.swift
//  FWRouter
//
//  Created by Wang Jianwei on 2018/10/13.
//

public final class Route<Output> {
    public var path: [PathComponent]
    public var output: Output
    public init(path: [PathComponent], output: Output) {
        self.path = path
        self.output = output
    }
}
