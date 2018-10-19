//
//  Parameter.swift
//  FWRouter
//
//  Created by Wang Jianwei on 2018/10/13.
//

public protocol Parameter {
    
    associatedtype ResolvedParameter
    
    static var routingSlug: String { get }
    
    static func resolveParameter(_ parameter: String) -> ResolvedParameter
}

extension Parameter {
    public static var parameter: PathComponent {
        return .parameter(routingSlug)
    }
}

extension Parameter {
    public static var routingSlug: String {
        return "\(Self.self)".lowercased()
    }
}

extension String: Parameter {
    public static func resolveParameter(_ parameter: String) -> String {
        return parameter
    }
}

extension FixedWidthInteger {
    public static func resolveParameter(_ parameter: String) -> Self? {
        guard let number = Self(parameter) else {
            return nil
        }
        return number
    }
}

extension Int: Parameter { }
extension Int8: Parameter { }
extension Int16: Parameter { }
extension Int32: Parameter { }
extension Int64: Parameter { }
extension UInt: Parameter { }
extension UInt8: Parameter { }
extension UInt16: Parameter { }
extension UInt32: Parameter { }
extension UInt64: Parameter { }

extension BinaryFloatingPoint {
    public static func resolveParameter(_ parameter: String) -> Self? {
        guard let number = Double(parameter) else {
            return nil
        }
        return Self(number)
    }
}

extension Float: Parameter { }
extension Double: Parameter { }


public struct ParameterValue {
    public let slug: String
    public let value: String
}

public struct Parameters: CustomStringConvertible {
    
    public var values: [ParameterValue] = []
    
    public mutating func next<P>(_ parameter: P.Type) -> P.ResolvedParameter? where P: Parameter {
        
        guard values.count > 0 else {
            return nil
        }
        
        let current = values[0]
        
        guard current.slug == P.routingSlug else {
            return nil
        }
        
        let item = P.resolveParameter(current.value)
        values = Array(values.dropFirst())
        return item
    }
    public var description: String {
        return values
                .map { "\t" + $0.slug + " = " + $0.value }
                .joined(separator: "\n")
    }
}
