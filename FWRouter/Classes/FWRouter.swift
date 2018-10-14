//
//  FWRouter.swift
//  FWRouter
//
//  Created by Wang Jianwei on 2018/10/13.
//

public protocol Navigation: class {
    var navigation: UINavigationController? { get }
}


public protocol UIKit {
    var applicationDelegate: UIApplicationDelegate { get }
    var window: UIWindow? { get }
}

public typealias UIRouter = Navigation & UIKit

extension UIKit {
    public var window: UIWindow? {
        guard let w = applicationDelegate.window else {
            return nil
        }
        return w
    }
    
    public var applicationDelegate: UIApplicationDelegate {
        return UIApplication.shared.delegate!
    }
}

extension Navigation where Self: UIKit {
    public var navigation: UINavigationController? {
        guard let w = applicationDelegate.window as? UIWindow else {
            return nil
        }
        
        guard let root = w.rootViewController else {
            return nil
        }
        
        
        var tempNav: UINavigationController?
        
        if let nav = root as? UINavigationController {
            tempNav = nav
        }
        
        if let tab = root as? Navigation, let n = tab.navigation {
            tempNav = n
        }
        
        guard let vc = tempNav else {
            return nil
        }
        
        var topVC: UIViewController = vc
        
        while topVC.presentedViewController != nil {
            topVC = topVC.presentedViewController!
        }
        
        guard let currentNavigation = topVC as? UINavigationController else {
            return nil
        }
        
        return currentNavigation
    }
}

extension UITabBarController: Navigation {
    public var navigation: UINavigationController? {
        guard let nav = selectedViewController as? UINavigationController else {
            return nil
        }
        return nav
    }
}


public final class FWRouterManager {
    public static let shared = FWRouterManager()
    public let router: CoreRouter = CoreRouter.default()
    private init() { }
}

extension Target: UIRouter { }
