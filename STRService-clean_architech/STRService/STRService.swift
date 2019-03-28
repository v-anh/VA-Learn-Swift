//
//  STRService.swift
//  STRService
//
//  Created by Ngo Chi Hai on 3/28/19.
//  Copyright © 2019 Quyen Nguyen The. All rights reserved.
//
import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

open class STRService: STRAPI {
    open var path: String {
        fatalError("The path is require")
    }
    
    open var method: HTTPMethod {
        return .get
    }
    
    open var params: [String : Any]? {
        return nil
    }
    
    open var headers: [String : String]? {
        return nil
    }
    
    public init() {}
}

public extension STRService {
    
    public func execute<T: Mappable>(onSuccess: @escaping (T) -> Void,
                                     onError: @escaping (Error) -> Void) {
        
        URLSessionNetworkDispatcher<T>().dispatch(requestData: RequestData(path: path,
                                                                           method: method,
                                                                           params: getParameters(),
                                                                           headers: headers),
                                                  onSuccess: { (data: T) in
            UserDefaults.setLoopValue(value: 0)
            onSuccess(data)
        }) { (error) in
            UserDefaults.setLoopValue(value: 0)
            DispatchQueue.main.async {
                onError(error)
            }
        }
    }
    
    public func execute<T: Mappable>(onSuccess: @escaping ([T]) -> Void,
                                     onError: @escaping (Error) -> Void) {
        
        URLSessionNetworkDispatcher<T>().dispatch(requestData: RequestData(path: path,
                                                                           method: method,
                                                                           params: getParameters(),
                                                                           headers: headers),
                                                  onSuccess: { (data: [T]) in
            UserDefaults.setLoopValue(value: 0)
            onSuccess(data)
        }) { (error) in
            UserDefaults.setLoopValue(value: 0)
            DispatchQueue.main.async {
                onError(error)
            }
        }
    }
}

extension STRService {
    
    func getParameters() -> [String : Any]? {
        
        var parameters = params
        if STRCore.getConfig().enableToken {
            parameters = params == nil ? [:] : params
            parameters?[STRCore.getConfig().refreshTokenConfig?.tokenParameterKey ?? "token"] = STRCore.getViewable().getToken(key: "Token")
        }
        return parameters
    }
}
