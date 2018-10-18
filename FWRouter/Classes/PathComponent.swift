//
//  PathComponent.swift
//  FWRouter
//
//  Created by Wang Jianwei on 2018/10/13.
//
public enum PathComponent: ExpressibleByStringLiteral {
    case constant(String)
    case parameter(String)
    case anything
    case catchall
    public init(stringLiteral value: String) {
        self = .constant(value)
    }
}

public let any: PathComponent = .anything
public let all: PathComponent = .catchall

public protocol PathComponentsRepresentable {
    func convertToPathComponents() -> [PathComponent]
}

extension PathComponent: PathComponentsRepresentable {
    public func convertToPathComponents() -> [PathComponent] {
        return [self]
    }
}

extension String: PathComponentsRepresentable {
    public func convertToPathComponents() -> [PathComponent] {
        return split(separator: "/").map { .constant(.init($0)) }
    }
}

extension Array: PathComponentsRepresentable where Element == PathComponentsRepresentable {
    public func convertToPathComponents() -> [PathComponent] {
        return flatMap { $0.convertToPathComponents() }
    }
}
