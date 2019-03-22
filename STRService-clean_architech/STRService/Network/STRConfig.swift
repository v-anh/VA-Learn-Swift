import Foundation

public protocol STRViewable {
    func showError(error: Error?)
    
    
    func getToken(key:String) -> String
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

class STRCore {
    
    private static let shared : STRCore = {
        let instance = STRCore()
        return instance
    }()
    
    private var config : Config?
    private var viewable: STRViewable?
    
    static func getConfig() -> Config {
        guard let config = STRCore.shared.config else {
            fatalError("Config is nil")
        }
        
        return config
    }
    
    static func getViewable() -> STRViewable {
        guard let viewable = STRCore.shared.viewable else {
            fatalError("viewable is nil")
        }
        
        return viewable
    }
    
    static func setup(config : Config, viewable:STRViewable) {
        STRCore.shared.config = config
        STRCore.shared.viewable = viewable
    }
}


extension UIApplicationDelegate {
    public func strConfig(config : Config, viewable:STRViewable) {
        STRCore.setup(config: config, viewable: viewable)
        STRNetworkManager.shared.setupNetwork()
    }
}
