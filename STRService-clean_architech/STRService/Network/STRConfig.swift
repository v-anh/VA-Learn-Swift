import Foundation

public protocol STRViewable {
    func showError(error: Error?)
}

public struct Config {
    public var shouldRecallWhenExpire: Bool = false
    public var enableToken: Bool = false
    var refreshTokenConfig: RefreshTokenConfig? = nil
    
    public init(){}
}

public struct RefreshTokenConfig {
    var tokenParameterKey: String
    var tokenStatusCodeExpire: Int
    var requestTokenData: RequestData
    var loopTime: Int
    
    public init(tokenFirstTime: String,
                tokenParameterKey: String,
                requestTokenData: RequestData,
                tokenStatusCodeExpire: Int = 460,
                loopTime: Int = 3) {
        UserDefaults.setToken(token: tokenFirstTime)
        self.tokenParameterKey = tokenParameterKey
        self.requestTokenData = requestTokenData
        self.tokenStatusCodeExpire = tokenStatusCodeExpire
        self.loopTime = loopTime
    }
}

public protocol STRDelegate {
    func showError(error: Error?)
//    func getToken() -> String
//    func refreshTokenData() -> RequestData
}

class STRConfig {
    
    static let shared : STRConfig = {
        let instance = STRConfig()
        return instance
    }()
    
    var config : Config?
    var viewable: STRViewable?
}


extension UIApplicationDelegate {
    public func strConfig(config : Config, viewable:STRViewable) {
        STRConfig.shared.config = config
        STRConfig.shared.viewable = viewable
        STRNetworkManager.shared.setupNetwork()
    }
}
