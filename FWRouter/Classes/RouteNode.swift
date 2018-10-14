//
//  RouteNode.swift
//  FWRouter
//
//  Created by Wang Jianwei on 2018/10/13.
//

final class RouteNode<Output> {
    
    var value: String
    var constants: [RouteNode<Output>]
    var parameter: RouteNode<Output>?
    var catchall: RouteNode<Output>?
    var anything: RouteNode<Output>?
    
    var output: Output?
    
    init(value: String, output: Output? = nil) {
        self.value = value
        self.output = output
        self.constants = []
    }
    
    func buildOrFetchChild(for component: PathComponent) -> RouteNode<Output> {
        switch component {
        case .constant(let value):
            for constant in constants {
                if constant.value == value {
                    return constant
                }
            }
            let node = RouteNode<Output>(value: value)
            constants.append(node)
            return node
        case .parameter(let value):
            let node: RouteNode<Output>
            if let parameter = self.parameter {
                node = parameter
            } else {
                node = RouteNode<Output>(value: value)
                self.parameter = node
            }
            return node
        case .catchall:
            let node: RouteNode<Output>
            if let fallback = self.catchall {
                node = fallback
            } else {
                // asterisk *
                node = RouteNode<Output>(value: "*")
                self.catchall = node
            }
            return node
        case .anything:
            let node: RouteNode<Output>
            if let anything = self.anything {
                node = anything
            } else {
                node = RouteNode<Output>(value: ":")
                self.anything = node
            }
            return node
        }
    }
}
