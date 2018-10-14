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
                        expect(target.url.url) == "scheme://host/test2"
                        expect(target.path.readable) == "/test2"
                        expect(target.path[0].url) == "/test2"
                        return true
                    })
                    expect(router.route(url: "scheme://host/test2")) == true
                })
            })
            context("Paramter", {
                it("Host + Path + Paramter", closure: {
                    router.match("scheme://host", "paramter", String.parameter, use: { (target) -> Bool in
                        expect(target.url) == "scheme://host/paramter/param0"
                        expect(target.pathParamters.next(String.self)) == "param0"
                        return true
                    })
                    expect(router.route(url: "scheme://host/paramter/param0")) == true
                })
                it("Host + Path + Paramter + Path", closure: {
                    router.match("scheme://host", "paramter", String.parameter, "test1", use: { (target) -> Bool in
                        expect(target.url) == "scheme://host/paramter/param0/test1"
                        expect(target.pathParamters.next(String.self)) == "param0"
                        return true
                    })
                    expect(router.route(url: "scheme://host/paramter/param0/test1")) == true
                })
                it("Host + Path + Int.Paramter", closure: {
                    router.match("scheme://host", "/paramter", "/int", Int.parameter, use: { (target) -> Bool in
                        expect(target.url) == "scheme://host/paramter/int/50"
                        expect(target.pathParamters.next(Int.self)) == 50
                        return true
                    })
                    expect(router.route(url: "scheme://host/paramter/int/50")) == true
                })
                it("Host + Path + Float.Paramter", closure: {
                    router.match("scheme://host", "/paramter", "/float", Float.parameter, use: { (target) -> Bool in
                        expect(target.url) == "scheme://host/paramter/float/50.3"
                        expect(target.pathParamters.next(Float.self)) == 50.3
                        return true
                    })
                    expect(router.route(url: "scheme://host/paramter/float/50.3")) == true
                })
            })

            context("Any & All", {
                it("Any", closure: {
                    router.match(any, use: { (target) -> Bool in
                        expect(target.url) == "/anything"
                        return true
                    })
                    expect(router.route(url: "/anything")) == true
                })
                it("All", closure: {
                    router.match("all", all, use: { (target) -> Bool in
                        expect(target.url) == "/all/wangfei"
                        return true
                    })
                    expect(router.route(url: "/all/wangfei")) == true
                })
            })
        }
    }
}
