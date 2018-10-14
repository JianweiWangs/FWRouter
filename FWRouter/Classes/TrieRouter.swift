//
//  TrieRouter.swift
//  FWRouter
//
//  Created by Wang Jianwei on 2018/10/13.
//

public final class TrieRouter<Output> {
    public private(set) var routes: [Route<Output>]
    private var root: RouteNode<Output>
    
    public init(_ type: Output.Type = Output.self) {
        self.root = RouteNode<Output>(value: "/")
        self.routes = []
    }
    
    public func register(route: Route<Output>) {
        routes.append(route)
        
        var current = root
        
        for component in route.path {
            current = current.buildOrFetchChild(for: component)
        }
        
        current.output = route.output
    }
    
    public func route<C>(path: [C], parameters: inout Parameters) -> Output? where C: RoutableComponent {
        var currentNode: RouteNode = root
        
        search: for path in path {
            for constant in currentNode.constants {
                // TODO: path match
                if constant.value.routerCompare(to: path.routerParameterValue) {
                    currentNode = constant
                    continue search
                }
            }
            
            if let parameter = currentNode.parameter {
                let value = ParameterValue(slug: parameter.value, value: path.routerParameterValue)
                parameters.values.append(value)
                currentNode = parameter
                continue search
            }
            
            if let anything = currentNode.anything {
                currentNode = anything
                continue search
            }
            
            if let catchall = currentNode.catchall {
                return catchall.output
            }
            
            return nil
        }
        
        return currentNode.output
    }
}
