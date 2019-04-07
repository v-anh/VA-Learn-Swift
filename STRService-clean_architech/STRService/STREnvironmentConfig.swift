//
//  STREnvironmentConfig.swift
//  STRService
//
//  Created by Ngo Chi Hai on 4/5/19.
//  Copyright © 2019 Quyen Nguyen The. All rights reserved.
//

import Foundation

private let dataProtocolKey = "STREnvironmentConfig_DataProtocolKey"
private let environmentKey  = "STREnvironmentConfig_EnvironmentKey"
private let serviceKey      = "STREnvironmentConfig_ServiceKey"

public enum DataProtocol: Int {
    case https
    case http
    
    var schema: String {
        switch self {
        case .https:
            return "https"
        case .http:
            return "http"
        }
    }
}

public enum Environment: Int {
    case test
    case production
    case mockserver
    case local
    
    var host: String {
        switch self {
        case .test:
            return STRSessionManager.shared.environmentConfig.getEnvironmentHostTest()
        case .production:
            return STRSessionManager.shared.environmentConfig.getEnvironmentHostProduction()
        case .mockserver:
            return STRSessionManager.shared.environmentConfig.getEnvironmentHostMockServer()
        case .local:
            return STRSessionManager.shared.environmentConfig.getEnvironmentHostLocal()
        }
    }
    
    var port: String? {
        switch self {
        case .local:
            return STRSessionManager.shared.environmentConfig.getEnvironmentPortLocal()
        case .mockserver:
            return STRSessionManager.shared.environmentConfig.getEnvironmentPortMockServer()
        default:
            return nil
        }
    }
}

public enum Service: Int {
    case sit
    case uat
    case production
    
    var path: String {
        switch self {
        case .sit:
            return STRSessionManager.shared.environmentConfig.getServicePathSit()
        case .uat:
            return STRSessionManager.shared.environmentConfig.getServicePathUat()
        case .production:
            return STRSessionManager.shared.environmentConfig.getServicePathProduction()
        }
    }
}

public struct STREnvironmentConfig {
    var dataProtocol: DataProtocol
    var environment: Environment
    var service: Service
    
    init() {
        let userDefaults = UserDefaults.standard
        self.dataProtocol = DataProtocol(rawValue: userDefaults.integer(forKey: dataProtocolKey))! //default https
        self.environment = Environment(rawValue: userDefaults.integer(forKey: environmentKey))! //default test
        self.service = Service(rawValue: userDefaults.integer(forKey: serviceKey))! //default sit
    }
    
    public init(dataProtocol: DataProtocol, environment: Environment, service: Service) {
        self.dataProtocol = dataProtocol
        self.environment = environment
        self.service = service
    }
}

public class STREnvironmentConfigurationManager {
    public static let shared = STREnvironmentConfigurationManager()
    
    public var config: STREnvironmentConfig = STREnvironmentConfig() {
        didSet {
            let userDefaults = UserDefaults.standard
            userDefaults.set(config.dataProtocol.rawValue, forKey: dataProtocolKey)
            userDefaults.set(config.environment.rawValue, forKey: environmentKey)
            userDefaults.set(config.service.rawValue, forKey: serviceKey)
            userDefaults.synchronize()
        }
    }
}
