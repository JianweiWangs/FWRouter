//
//  AppDelegate.swift
//  FWRouter
//
//  Created by Wang Jianwei on 09/20/2018.
//  Copyright (c) 2018 Wang Jianwei. All rights reserved.
//

import UIKit
import FWRouter
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let vc = UIStoryboard(name: "Main", bundle: .main).instantiateInitialViewController()
        let nav = UINavigationController(rootViewController: vc!)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        
        // nav controller
//        window?.rootViewController = nav
        
        
        // tab controller
        let tab = UITabBarController()
        tab.viewControllers = [nav]
        window?.rootViewController = tab
        
        
        let route = FWRouterManager.shared.router
        
        route.match("https://www.wangjianwei.com/dd", "demo", String.parameter, "subtitle", String.parameter) { (target) -> Bool in
            let demoVC = DemoViewController()
            let title = target.pathParamters.next(String.self)! + "+" + target.pathParamters.next(String.self)!
            demoVC.title = title
            target.navigation?.pushViewController(demoVC, animated: true)
            print(target.url)
            print(target.applicationDelegate)
            print(target.navigation)
            print(target.window)
            print(target)
            print(target.paramters["name"])
            return true
        }
        
        route.route(url: "https://www.wangjianwei.com/dd/demo/second/subtitle/title")
        
        return true
    }

}

class ViewController: UIViewController {
    
    let router = FWRouterManager.shared.router
    
    @IBAction func onClick(_ sender: Any) {
        guard router.route(url: "https://www.wangjianwei.com/dd/demo/second/subtitle/title", paramters: ["name": "wangjianwei"]) else {
            print("route failed")
            return
        }
        print("route success")
    }
    
    @IBAction func unmatchOnClick(_ sender: Any) {
        router.route(url: "http://www.xxx/xxx")
    }
}

class DemoViewController: UIViewController {
    
}


