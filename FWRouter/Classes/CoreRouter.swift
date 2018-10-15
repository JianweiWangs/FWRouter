//
//  CoreRouter.swift
//  FWRouter
//
//  Created by Wang Jianwei on 2018/10/13.
//

public final class CoreRouter: Router {
    
    private let router: TrieRouter<Action> = .init()
    
    public var routes: [Route<Action>] {
        return router.routes
    }
    
    public func register(route: Route<Action>) {
        router.register(route: route)
    }
    
    public func route(tar: Target) -> Action? {
        let path = tar.path.map { $0.path }
        return router.route(path: path, parameters: &tar.pathParameters)
    }
    
    public static func `default`() -> CoreRouter {
        return CoreRouter()
    }
    
    private init() {}
}

