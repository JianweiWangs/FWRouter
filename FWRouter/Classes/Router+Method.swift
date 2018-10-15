//
//  Router+Method.swift
//  FWRouter
//
//  Created by Wang Jianwei on 2018/10/13.
//

extension Router {
    @discardableResult
    public func route(url: URLComponentsRepresentable, parameters: [String: AnyHashable] = [:]) -> Bool {
        let target = Target(url: url, parameters: parameters)
        guard let resolution = route(tar: target) else {
            return false
        }
        return resolution.resolve(to: target)
    }
    
    
    public func match(_ url: URLComponentsRepresentable = "",_ path: PathComponentsRepresentable..., use closure: @escaping (Target) -> Bool) {
        match(url, path: path.convertToPathComponents(), use: closure)
    }
}

extension Router {
    
    private func match(_ url: URLComponentsRepresentable, path: [PathComponent], use closure: @escaping (Target) -> Bool) {
        let resolution = BasicAction {
            return closure($0)
        }
        let allPath = url.convertURLToPathComponents() + path
        let route = Route<Action>(path: allPath, output: resolution)
        register(route: route)
    }
}





