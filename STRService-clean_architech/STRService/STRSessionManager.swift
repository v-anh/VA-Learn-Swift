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
    public var delegate: STRDelegate!
    public var errorHandler: STRAPIErrorHandling!
    
    public static let shared = STRSessionManager()
    
    private var networkManager: SessionManager!
    init() {
        setupNetwork()
    }
    
    func setupNetwork() {
        let configuration = URLSessionConfiguration.default
        networkManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    
    func callService<T: Mappable>(requestData: RequestData, onSuccess: @escaping (DataResponse<T>) -> Void) {
        networkManager.request(requestData.path,
                               method: requestData.method.key,
                               parameters: requestData.params,
                               encoding: JSONEncoding.default,
                               headers: requestData.headers).responseObject(completionHandler: onSuccess)
        
    }
    
    func callService<T: Mappable>(requestData: RequestData, onSuccess: @escaping (DataResponse<[T]>) -> Void) {
        networkManager.request(requestData.path,
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

/*
 Configuration:
 - Setup Config
 */
extension STRSessionManager {
    
    static func setup(config : STRConfiguration) {
        STRSessionManager.shared.config = config
        STRSessionManager.shared.delegate = config
        STRSessionManager.shared.errorHandler = config
    }
    
}
