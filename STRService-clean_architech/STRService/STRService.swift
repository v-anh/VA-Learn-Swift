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
import PromiseKit

open class STRService: STRAPI {
    
    open var path: String {
        fatalError("The path is require")
    }
    
    open var method: APIMethod {
        return .GET
    }
    
    open var params: [String : Any]? {
        return nil
    }
    
    open var headers: [String : String]? {
        return nil
    }
    
    
    public init() {}
    
    
    private var handlerErrorManually:Bool = false
    public func set(handlerErrorManually:Bool) -> STRService {
        self.handlerErrorManually = handlerErrorManually
        return self
    }
    
    private var handlerErrorCompletion:((Error) -> Void)?
    public func set(handlerErrorCompletion:((Error) -> Void)?) -> STRService {
        self.handlerErrorCompletion = handlerErrorCompletion
        return self
    }
}

public extension STRService {
    
    func execute<T: Mappable>(shouldMock:Bool = false,onSuccess: @escaping (T) -> Void,
                              onError: @escaping (Error) -> Void) {
        
        //TODO:- Check mock data
        if shouldMock == true {
            self.mockHandler()
        }
        
        //TODO:- Check network connection
        guard let isReachable = NetworkReachabilityManager()?.isReachable,isReachable else{
            self.responseHandlerError(statusCode: .noConnection) { (error) in
                onError(error)
            }
            return
        }
        
        //TODO:- Check config for retry when no-connection
        
        //TODO:- retry when no-connection
        
        //TODO:- Get Scheme and host for Callservice
        
        //TODO:- Callservice
        
        let requestData = RequestData(path: path,
                                      method: method,
                                      params: getParameters(),
                                      headers: headers)
        STRSessionManager.shared.callService(requestData: requestData) { (response: DataResponse<T>) in
            
            self.responseHandler(response: response, onSuccess: onSuccess, onError: onError)
        }
    }
    
    func execute<T: Mappable>(shouldMock:Bool = false,onSuccess: @escaping ([T]) -> Void,
                              onError: @escaping (Error) -> Void) {
        
        let requestData = RequestData(path: path,
                                      method: method,
                                      params: getParameters(),
                                      headers: headers)
        
        
        //TODO:- Check mock data
        
        //TODO:- Check network connection
        
        //TODO:- Check config for retry when no-connection
        
        //TODO:- retry when no-connection
        
        //TODO:- Get Scheme and host for Callservice
        
        //TODO:- Callservice
        
        STRSessionManager.shared.callService(requestData: requestData) { (response: DataResponse<[T]>) in
            self.responseHandler(response: response, onSuccess: onSuccess, onError: onError)
        }
    }
    
    
    
    func execute<T: Mappable>(shouldMock: Bool) -> Promise<T> {
        
        //TODO:- Check config for retry when no-connection
        
        //TODO:- retry when no-connection
        
        //TODO:- Get Scheme and host for Callservice
        
        //TODO:- Callservice
        
        //        let requestData = RequestData(path: path,
        //                                      method: method,
        //                                      params: getParameters(),
        //                                      headers: headers)
        //        STRSessionManager.shared.callService(requestData: requestData) { (response: DataResponse<T>) in
        //
        //            self.responseHandler(response: response, onSuccess: onSuccess, onError: onError)
        //        }
        
        //TODO:- Check mock data
        if shouldMock == true {
            return self.mockHandler()
        }
        return Promise<T>{ seal in
            
            //TODO:- Check network connection
            guard let isReachable = NetworkReachabilityManager()?.isReachable,isReachable else{
                STRSessionManager.shared.errorHandler.onNetworkError(api: self)
                    .done { (retry) in
                        if retry == true {
                            self.executeAgain().done{ res in
                                seal.fulfill(res)
                                }.catch{error in
                                    seal.reject(error)
                            }
                        }
                    }.catch{(error) in
                        seal.reject(error)
                }
                return
            }
        }
    }
    
    func executeAgain<T: Mappable>(shouldMock: Bool = false) -> Promise<T> {
        return Promise<T>{ seal in
            
        }
    }
}

extension STRService {
    
    private func getParameters() -> [String : Any]? {
        
        var parameters = params
        if STRSessionManager.shared.config.shouldEnableToken() {
            parameters = params == nil ? [:] : params
            parameters?[STRSessionManager.shared.config.tokenParameterKey() ?? "token"] = STRSessionManager.shared.delegate.getToken(key: "Token")
        }
        return parameters
    }
}

extension STRService {
    private func responseHandler<T: Mappable>(response: DataResponse<T>, onSuccess: @escaping(T) -> Void, onError:@escaping(Error) -> Void) {
        guard let statusCode = StatusCode(rawValue: response.response?.statusCode ?? StatusCode.unknown.hashValue) else {
            onError(STRError.noResponse)
            return
        }
        
        switch statusCode {
        case .success:
            guard let data = response.result.value else {
                onError(STRError.noData)
                return
            }
            
            onSuccess(data)
        default:
            responseHandlerError(statusCode: statusCode) { (error) in
                onError(error)
            }
        }
    }
    
    private func responseHandler<T: Mappable>(response: DataResponse<[T]>, onSuccess: @escaping([T]) -> Void, onError:@escaping(Error) -> Void) {
        guard let statusCode = StatusCode(rawValue: response.response?.statusCode ?? StatusCode.unknown.hashValue) else {
            onError(STRError.noResponse)
            return
        }
        
        switch statusCode {
        case .success:
            guard let data = response.result.value else {
                onError(STRError.noData)
                return
            }
            
            onSuccess(data)
        default:
            responseHandlerError(statusCode: statusCode) { (error) in
                onError(error)
            }
        }
    }
    
    private func responseHandlerError(statusCode: StatusCode, onError: @escaping (Error) -> Void) {
        
        guard let error = statusCode.toError() else {
            print("STRService Can not found Error with status: \(statusCode.hashValue)")
            return
        }
        
        
        if self.handlerErrorManually == true {
            if let handleError = self.handlerErrorCompletion {
                handleError(error)
            }
        }else{
            STRSessionManager.shared.delegate.showError(error: error)
        }
    }
    
    //    func refreshToken(onSuccess: @escaping (Any) -> Void, onError: @escaping (Error) -> Void) {
    //        guard let loopTime = STRSessionManager.shared.config.loopTime(),
    //            UserDefaults.getLoopValue() < loopTime else {
    //                onError(STRError.refreshTokenError)
    //                return
    //        }
    //        UserDefaults.setLoopValue(value: UserDefaults.getLoopValue() + 1)
    //
    //        guard let requestData = STRSessionManager.shared.config.requestTokenData() else {
    //            onError(STRError.noRefreshTokenData)
    //            return
    //        }
    //
    //        var parameters = requestData.params
    //        parameters?[STRSessionManager.shared.config.tokenParameterKey() ?? "token"] = UserDefaults.getToken()
    //
    //        networkManager.request(requestData.path, method: requestData.method, parameters: parameters, encoding: JSONEncoding.default, headers: requestData.headers).responseObject { (response: DataResponse<T>) in
    //
    //            self.responseHandler(response: response, onSuccess: { (dic) in
    //                if let dicData = dic as? [String: Any], let token = dicData["token"] as? String {
    //                    UserDefaults.setToken(token: token)
    //                }
    //                onSuccess(dic)
    //            }, onError: { (error) in
    //                self.refreshToken(onSuccess: onSuccess, onError: onError)
    //            })
    //        }
    //    }
}


public extension STRService {
    @available(*,deprecated,message:  "mockHandler<T: Mappable>() -> Promise<T> instead")
    private func mockHandler() {
    }
    
    
    private func mockHandler<T: Mappable>() -> Promise<T> {
        return Promise<T>{ seal in
            seal.reject(STRError.unknown)
        }
    }
}
