import UIKit
import STRService
import netfox
import PromiseKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    //fixthis


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        strConfig(config: self)
        configure(dependency: CoreDependency())
        
        #if DEBUG
        NFX.sharedInstance().start()
        #endif
        
        return true
    }


}

extension AppDelegate: STRDelegate, STRConfig {
    func getToken(key: String) -> String {
        return "Token store in Keychain"
    }
    
    func showLog(log: String) {
        print(log)
    }
}

extension AppDelegate: STRAPIErrorHandling {
    func onNetworkNotReachable(api: STRService) -> Promise<Retry> {
        //
        //
        // test rebase
        //
        //
        return Promise<Retry> { seal in
            seal.fulfill(false)
        }
    }
    
    func onServerTimeout(api: STRService) -> Promise<Retry> {
        return Promise<Retry> { seal in
            seal.fulfill(false)
        }
    }
    
    func onNetworkError(error: STRError) {
        
    }
}

extension AppDelegate: STREnvironmentConfiguration {
    
    func getEnvironmentHostTest() -> String {
        return "omgvamp-hearthstone-v1.p.rapidapi.com"
    }
    
    func getServicePathSit() -> String {
        return ""
    }
}
