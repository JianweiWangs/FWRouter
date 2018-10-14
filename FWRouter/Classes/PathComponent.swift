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

extension Array where Element == PathComponent {
    public var readable: String {
        return "/" + map {
            switch $0 {
            case .constant(let s): return s
            case .parameter(let p): return ":\(p)"
            case .anything: return ":"
            case .catchall: return "*"
            }
            }.joined(separator: "/")
    }
}

public protocol PathComponentsRepresentable {
    func convertToPathComponents() -> [PathComponent]
}

extension PathComponent: PathComponentsRepresentable {
    public func convertToPathComponents() -> [PathComponent] {
        return [self]
    }
    public var path: String {
        switch self {
        case .constant(let s): return s
        case .parameter(let p): return ":\(p)"
        case .anything: return ":"
        case .catchall: return "*"
        }
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
