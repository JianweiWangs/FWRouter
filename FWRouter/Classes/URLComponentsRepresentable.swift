//
//  URLComponentsRepresentable.swift
//  FWRouter
//
//  Created by Wang Jianwei on 2018/10/14.
//

public protocol URLComponentsRepresentable {
    var url: String { get }
    var origin: String { get }
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    func convertURLToPathComponents() -> [PathComponent]
}


extension URLComponentsRepresentable {
    public func convertURLToPathComponents() -> [PathComponent] {
        guard let component = URLComponents(string: url) else {
            return []
        }
        return host.convertToPathComponents() + component.path.convertToPathComponents()
    }
    public var scheme: String {
        guard let components = URLComponents(string: url) else {
            return ""
        }
        guard let scheme = components.scheme else {
            return ""
        }
        return scheme
    }
    
    public var host: String {
        guard let components = URLComponents(string: url) else {
            return ""
        }
        
        guard let host = components.host else {
            return ""
        }
        return host
    }
    
    public var path: String {
        guard let components = URLComponents(string: url) else {
            return ""
        }
        return components.path
    }
    
    public var origin: String {
        return scheme + "://" + host
    }
}


extension String: URLComponentsRepresentable {
    public var url: String {
        return self
    }
}


