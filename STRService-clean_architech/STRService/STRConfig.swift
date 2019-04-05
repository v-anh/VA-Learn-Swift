import Foundation
import PromiseKit

public typealias STRConfiguration = STRDelegate & STRConfig & STRAPIErrorHandling & STREnvironmentConfiguration

public protocol STRDelegate {
    func getToken(key:String) -> String
}

public protocol STREnvironmentConfiguration {
    
    //Environment Config
    func getEnvironmentHostTest() -> String
    
    func getEnvironmentHostProduction() -> String
    
    func getEnvironmentHostMockServer() -> String
    
    func getEnvironmentHostLocal() -> String
    
    func getEnvironmentPortMockServer() -> String
    
    func getEnvironmentPortLocal() -> String
    
    //Service config
    func getServicePathSit() -> String
    
    func getServicePathUat() -> String
    
    func getServicePathProduction() -> String
}

public extension STREnvironmentConfiguration {
    //Environment Config
    func getEnvironmentHostTest() -> String {
        return ""
    }
    
    func getEnvironmentHostProduction() -> String {
        return ""
    }
    
    func getEnvironmentHostMockServer() -> String {
        return ""
    }
    
    func getEnvironmentHostLocal() -> String {
        return ""
    }
    
    func getEnvironmentPortMockServer() -> String {
        return ""
    }
    
    func getEnvironmentPortLocal() -> String {
        return ""
    }
    
    //Service config
    func getServicePathSit() -> String {
        return ""
    }
    
    func getServicePathUat() -> String {
        return ""
    }
    
    func getServicePathProduction() -> String {
        return ""
    }
}

public typealias Retry = Bool
public protocol STRAPIErrorHandling {
    func onNetworkNotReachable(api: STRService) -> Promise<Retry>
    
    func onServerTimeout(api: STRService) -> Promise<Retry>
    
    func onNetworkError(error: STRError)
}

public protocol STRConfig {
    
    func shouldRecallWhenExpire() -> Bool
    
    func shouldEnableToken() -> Bool
    
    func tokenParameterKey() -> String?
    
    func tokenStatusCodeExpire() -> Int?
    
    func requestTokenData() -> RequestData?
    
    func loopTime() -> Int?
}


public extension STRConfig {
    func shouldRecallWhenExpire() -> Bool {
        return false
    }
    
    func shouldEnableToken() -> Bool {
        return false
    }
    
    func tokenParameterKey() -> String? {
        return ""
    }
    
    func tokenStatusCodeExpire() -> Int? {
        return nil
    }
    
    func requestTokenData() -> RequestData? {
        return nil
    }
    
    func loopTime() -> Int? {
        return nil
    }
}

extension UIApplicationDelegate {
    public func strConfig(config : STRConfiguration) {
        STRSessionManager.setup(config: config)
    }
}
