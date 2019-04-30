//
//  STRSessionManager.swift
//  STRService
//
//  Created by Anh Tran on 3/29/19.
//  Copyright © 2019 Quyen Nguyen The. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

typealias JSONResponseHandler = ((_ result:Any?,_ error:Error?) -> Void)?
public final class STRSessionManager {
    
    public var config : STRConfig!
    public var environmentConfig: STREnvironmentConfiguration!
    public var delegate: STRDelegate!
    public var errorHandler: STRAPIErrorHandling!
    
    public static let shared = STRSessionManager()
    
    static var environmentConfigurationManager: STREnvironmentConfigurationManager = .shared
    
    private var networkManager: SessionManager!
    init() {
        setupNetwork()
        
    }
    
    func setupNetwork() {
        let configuration = URLSessionConfiguration.default
        networkManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    
    func callService<T: Mappable>(requestData: RequestData, onSuccess: @escaping (DataResponse<T>) -> Void) {
        networkManager.request(serviceURL(with: requestData.path) ?? "",
                               method: requestData.method.key,
                               parameters: requestData.params,
                               encoding: JSONEncoding.default,
                               headers: requestData.headers).responseObject(completionHandler: onSuccess)
        
    }
    
    func callService<T: Mappable>(requestData: RequestData, onSuccess: @escaping (DataResponse<[T]>) -> Void) {
        networkManager.request(serviceURL(with: requestData.path) ?? "",
                               method: requestData.method.key,
                               parameters: requestData.params,
                               encoding: JSONEncoding.default,
                               headers: requestData.headers).responseArray(completionHandler: onSuccess)
    }
    
//    func callService(requestData: RequestData, completionHandler: JSONResponseHandler) {
//        networkManager.request(requestData.path,
//                               method: requestData.method.key,
//                               parameters: requestData.params,
//                               encoding: JSONEncoding.default,
//                               headers: requestData.headers)
//            .responseJSON { (response) in
//                guard let responseHandler = completionHandler, let data = response.data else {
//                    return
//                }
//                responseHandler(data,response.error)
//        }
//    }
}

//MARK: Private Method
extension STRSessionManager {
    
    // Configure service URL depend on environment configuration
    private func serviceURL(with path: String) -> URL? {
        var urlCommonents = URLComponents()
        urlCommonents.scheme = STRSessionManager.environmentConfigurationManager.config.dataProtocol.schema
        urlCommonents.host = STRSessionManager.environmentConfigurationManager.config.environment.host
        
        if let port = STRSessionManager.environmentConfigurationManager.config.environment.port {
            urlCommonents.port = Int(port)
        }
        
        if STRSessionManager.environmentConfigurationManager.config.service.path !=  "" {
            urlCommonents.path = "/" + STRSessionManager.environmentConfigurationManager.config.service.path + "/" + path
        } else {
            urlCommonents.path = "/" + path
        }
        
        return urlCommonents.url
    }
}

/*
 Configuration:
 - Setup Config
 */
extension STRSessionManager {
    
    static func setup(config : STRConfiguration) {
        STRSessionManager.shared.config = config
        STRSessionManager.shared.delegate = config
        STRSessionManager.shared.errorHandler = config
        STRSessionManager.shared.environmentConfig = config
    }
    
}
