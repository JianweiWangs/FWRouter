// https://github.com/Quick/Quick

import Quick
import Nimble
import FWRouter

class FWRouterSpec: QuickSpec {
    override func spec() {
        let router = FWRouterManager.shared.router
        describe("FWRouter Test") {
            var testTimes = 0
            afterSuite {
                // advoid project running effect, could use fake application instead of it.
                expect(router.routes.count) >= testTimes
            }
            afterEach {
                testTimes += 1
            }
            context("Host + Path Router Match", {
                it("Host/Path + Path", closure: {
                    router.match("scheme://host/path", "test1", use: { (target) -> Bool in
                        expect(target.url) == "scheme://host/path/test1"
                        return true
                    })
                    expect(router.route(url: "scheme://host/path/test1")) == true
                })
                
                it("Host + Path", closure: {
                    router.match("scheme://host", "test2", use: { (target) -> Bool in
                        expect(target.url) == "scheme://host/test2"
                        expect(target.url.origin) == "scheme://host"
                        return true
                    })
                    expect(router.route(url: "scheme://host/test2")) == true
                })
            })
            context("PathParameter", {
                it("Host + Path + Parameter", closure: {
                    router.match("scheme://host", "parameter", String.parameter, use: { (target) -> Bool in
                        expect(target.url) == "scheme://host/parameter/param0"
                        expect(target.pathParameters.next(String.self)) == "param0"
                        return true
                    })
                    expect(router.route(url: "scheme://host/parameter/param0")) == true
                })
                it("Host + Path + Parameter + Path", closure: {
                    router.match("scheme://host", "parameter", String.parameter, "test1", use: { (target) -> Bool in
                        expect(target.url) == "scheme://host/parameter/param0/test1"
                        expect(target.pathParameters.next(String.self)) == "param0"
                        return true
                    })
                    expect(router.route(url: "scheme://host/parameter/param0/test1")) == true
                })
                it("Host + Path + Int.Parameter", closure: {
                    router.match("scheme://host", "/parameter", "/int", Int.parameter, use: { (target) -> Bool in
                        expect(target.url) == "scheme://host/parameter/int/50"
                        expect(target.pathParameters.next(Int.self)) == 50
                        return true
                    })
                    expect(router.route(url: "scheme://host/parameter/int/50")) == true
                })
                it("Host + Path + Float.Parameter", closure: {
                    router.match("scheme://host", "/parameter", "/float", Float.parameter, use: { (target) -> Bool in
                        expect(target.url) == "scheme://host/parameter/float/50.3"
                        expect(target.pathParameters.next(Float.self)) == 50.3
                        return true
                    })
                    expect(router.route(url: "scheme://host/parameter/float/50.3")) == true
                })
            })

            context("Any & All", {
                it("Host + Path + Any", closure: {
                    router.match("scheme://host/path", path: [any, PathComponent(stringLiteral: "path2"), Int.parameter, String.parameter], use: { (target) -> Bool in
                        expect(target.url) == "scheme://host/path/testAny/path2/65/asd"
                        print(target)
                        return true
                    })
                    expect(router.route(url: "scheme://host/path/testAny/path2/65/asd")) == true
                })
                it("All", closure: {
                    router.match("all", all, use: { (target) -> Bool in
                        expect(target.url) == "/all/wangfei"
                        return true
                    })
                    expect(router.route(url: "/all/wangfei")) == true
                    expect(router.route(url: "/all1/wangfei")) == false
                })
            })

            context("Parameter", {
                it("route with parameter", closure: {
                    router.match("scheme://host/path", "/thridParameter", use: { (target) -> Bool in
                        expect(target.parameters["name"] as? String) == "wangjianwei"
                        return true
                    })
                    expect(router.route(url: "scheme://host/path/thridParameter", parameters: ["name": "wangjianwei"])) == true
                })
            })
        }
    }
}
