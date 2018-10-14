//
//  URLComponentsRepresentable.swift
//  FWRouter
//
//  Created by Wang Jianwei on 2018/10/14.
//

public protocol URLComponentsRepresentable {
    var url: String { get }
    func convertURLToPathComponents() -> [PathComponent]
}

extension PathComponent: URLComponentsRepresentable {
    public func convertURLToPathComponents() -> [PathComponent] {
        return convertToPathComponents()
    }
    
    public var url: String {
        return convertToPathComponents().readable
    }
}

extension String: URLComponentsRepresentable {
    public var url: String {
        guard URLComponents(string: self) != nil else {
            return ""
        }
        return self
    }
    
    public func convertURLToPathComponents() -> [PathComponent] {
        guard let component = URLComponents(string: self) else {
            return []
        }
        return component.path.convertToPathComponents()
    }
}


