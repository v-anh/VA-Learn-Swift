import Foundation

public typealias STRConfiguration = STRDelegate & STRConfig

public protocol STRDelegate {
    func showError(error: Error?)
    func getToken(key:String) -> String
}

public protocol STRConfig {
    
    func shouldRecallWhenExpire() -> Bool
    
    func shouldEnableToken() -> Bool
    
    func tokenParameterKey() -> String?
    
    func tokenStatusCodeExpire() -> Int?
    
    func requestTokenData() -> RequestData?
    
    func loopTime() -> Int?
}

extension UIApplicationDelegate {
    public func strConfig(config : STRConfiguration) {
        STRSessionManager.setup(config: config)
    }
}
