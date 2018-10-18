//
//  Intent.swift
//  FWRouter
//
//  Created by Wang Jianwei on 2018/10/13.
//

public final class Target: CustomStringConvertible {
    public var description: String {
        let des: [String] = [
            "url = " + url.url,
            "parameters = {\n" + pathParameters.description + "\n}",
        ]
        return des.joined(separator: "\n")
    }
    public let url: String
    public var pathParameters: Parameters = .init()
    public let parameters: [String: AnyHashable]
    public init(url: URLComponentsRepresentable, parameters: [String: AnyHashable] = [:]) {
        self.url = url.url
        self.parameters = parameters
    }
}
