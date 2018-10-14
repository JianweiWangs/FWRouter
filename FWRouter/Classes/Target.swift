//
//  Intent.swift
//  FWRouter
//
//  Created by Wang Jianwei on 2018/10/13.
//

public final class Target: CustomStringConvertible {
    public var description: String {
        let des: [String] = [
            "url = " + url,
            "parameters = " + pathParamters.description,
        ]
        return des.joined(separator: "\n")
    }
    public var path: [PathComponent] {
        let components = URLComponents(string: url)
        guard let unwrapComponents = components else { return [] }
        return unwrapComponents.path.convertToPathComponents()
    }
    public let url: String
    public var pathParamters: Parameters = .init()
    public let paramters: [String: AnyHashable]
    public init(url: URLComponentsRepresentable, paramters: [String: AnyHashable] = [:]) {
        self.url = url.url
        self.paramters = paramters
    }
}
