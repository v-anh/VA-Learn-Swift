import Foundation
import PromiseKit

public typealias STRConfiguration = STRDelegate & STRConfig & STRAPIErrorHandling

public protocol STRDelegate {
    @available(*, deprecated, message: "STRAPIErrorHandling instead")
    func showError(error: Error)
    func getToken(key:String) -> String
}


public typealias Retry = Bool
public protocol STRAPIErrorHandling {
    func onNetworkError(api:STRService) -> Promise<Retry>
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
