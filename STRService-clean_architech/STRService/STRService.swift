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

//MARK: Public
public extension STRService {
    
    
    func execute<T: Mappable>() -> Promise<T> {
        
        //TODO:- Check mock data
//        if shouldMock == true {
//            return self.mockHandler()
//        }
        
        return Promise<T>{ seal in
            
            //TODO:- Check network connection
            guard let isReachable = NetworkReachabilityManager()?.isReachable,isReachable else{
                
                 //TODO:- Retry when no-connection
                STRSessionManager.shared.errorHandler.onNetworkNotReachable(api: self)
                    .done { (retry) in
                        //TODO:- Check config for retry when no-connection
                        if retry == true {
                            self.executeAgain().done{ res in
                                seal.fulfill(res)
                                }.catch{error in
                                    seal.reject(error)
                            }
                        }
                    }.catch{    (error) in
                        seal.reject(error)
                }
                return
            }
            
            //TODO:- Callservice
            let requestData = RequestData(path: path,
                                          method: method,
                                          params: getParameters(),
                                          headers: headers)
            STRSessionManager.shared.callService(requestData: requestData) { (response: DataResponse<T>) in
                
                self.responseHandler(response: response).done { (data) in
                    seal.fulfill(data)
                }.catch { (error) in
                    seal.reject(error)
                }
            }
        }
    }
    
    func execute<T: Mappable>() -> Promise<[T]> {
        
        //TODO:- Check mock data
//        if shouldMock == true {
//            return self.mockHandler()
//        }
        return Promise<[T]>{ seal in
            //
            //TODO:- Check network connection
            guard let isReachable = NetworkReachabilityManager()?.isReachable,isReachable else{
                
                //TODO:- retry when no-connection
                STRSessionManager.shared.errorHandler.onNetworkNotReachable(api: self)
                    .done { (retry) in
                        //TODO:- Check config for retry when no-connection
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
            
            //TODO:- Callservice
            let requestData = RequestData(path: path,
                                          method: method,
                                          params: getParameters(),
                                          headers: headers)
            STRSessionManager.shared.callService(requestData: requestData) { (response: DataResponse<[T]>) in
                
                self.responseHandler(response: response).done { (data) in
                    seal.fulfill(data)
                    }.catch { (error) in
                        seal.reject(error)
                }
            }
        }
    }
    
}

//MARK: Private
extension STRService {
    
    private func executeAgain<T: Mappable>(shouldMock: Bool = false) -> Promise<T> {
        return Promise<T>{ seal in
            let requestData = RequestData(path: path,
                                          method: method,
                                          params: getParameters(),
                                          headers: headers)
            STRSessionManager.shared.callService(requestData: requestData) { (response: DataResponse<T>) in
                
                self.responseHandler(response: response).done { (data) in
                    seal.fulfill(data)
                    }.catch { (error) in
                        seal.reject(error)
                }
            }
        }
    }
    
    private func executeAgain<T: Mappable>(shouldMock: Bool = false) -> Promise<[T]> {
        return Promise<[T]>{ seal in
            let requestData = RequestData(path: path,
                                          method: method,
                                          params: getParameters(),
                                          headers: headers)
            STRSessionManager.shared.callService(requestData: requestData) { (response: DataResponse<[T]>) in
                
                self.responseHandler(response: response).done { (data) in
                    seal.fulfill(data)
                    }.catch { (error) in
                        seal.reject(error)
                }
            }
        }
    }
    
    private func responseHandler<T: Mappable>(response: DataResponse<T>) -> Promise<T> {
        return Promise<T> { seal in
            guard let statusCode = StatusCode(rawValue: response.response?.statusCode ?? StatusCode.unknown.hashValue) else {
                seal.reject(STRError(messageCode: .unknown, error: response.error))
                return
            }
            
            switch statusCode {
            case .success:
                guard let data = response.result.value else {
                    seal.reject(STRError(messageCode: .noData, error: response.error))
                    return
                }
                
                seal.fulfill(data)
            default:
                guard let error = response.error else {
                    seal.reject(STRError(messageCode: .unknown, error: response.error))
                    return
                }
                
                guard let strError = statusCode.toError(error: error) else {
                    print("STRService Can not found Error with status: \(statusCode.hashValue)")
                    return
                }
                
                responseHandlerError(error: strError).done { (result: T) in
                    seal.fulfill(result)
                    }.catch { (error) in
                        seal.reject(error)
                }
            }
        }
    }
    
    private func responseHandler<T: Mappable>(response: DataResponse<[T]>) -> Promise<[T]> {
        return Promise<[T]> { seal in
            guard let statusCode = StatusCode(rawValue: response.response?.statusCode ?? StatusCode.unknown.hashValue) else {
                seal.reject(STRError(messageCode: .unknown, error: response.error))
                return
            }
            
            switch statusCode {
            case .success:
                guard let data = response.result.value else {
                    seal.reject(STRError(messageCode: .noData, error: response.error))
                    return
                }
                
                seal.fulfill(data)
            default:
                guard let error = response.error else {
                    seal.reject(STRError(messageCode: .unknown, error: response.error))
                    return
                }
                
                guard let strError = statusCode.toError(error: error) else {
                    print("STRService Can not found Error with status: \(statusCode.hashValue)")
                    return
                }
                
                responseHandlerError(error: strError).done { (result: [T]) in
                    seal.fulfill(result)
                    }.catch { (error) in
                        seal.reject(error)
                }
            }
        }
    }
    
    private func responseHandlerError<T: Mappable>(error: STRError) -> Promise<T> {
        return Promise<T> { seal in
            //TODO: check normal Error
            
            //remove this
            
            
            if self.handlerErrorManually == true {
                if let handleError = self.handlerErrorCompletion {
                    handleError(error)
                }
            }else{
                
                //TODO: check Error have logic - Expire, Timeout, -> need to recall again
                switch error.status {
                case .timeout:
                    
                    STRSessionManager.shared.errorHandler.onServerTimeout(api: self).done { (retry) in
                        if retry == true {
                            self.executeAgain().done{ res in
                                seal.fulfill(res)
                                }.catch{error in
                                    seal.reject(error)
                            }
                        }
                        }.catch { (error) in
                            seal.reject(error)
                    }
                default:
                    STRSessionManager.shared.errorHandler.onNetworkError(error: error)
                }
                
                //TODO: Find more error?
                //STRSessionManager.shared.delegate.showError(error: error)
            }
        }
    }
    
    private func responseHandlerError<T: Mappable>(error: STRError) -> Promise<[T]> {
        return Promise<[T]> { seal in
            //TODO: check normal Error
            
            //remove this
            
            
            if self.handlerErrorManually == true {
                if let handleError = self.handlerErrorCompletion {
                    handleError(error)
                }
            }else{
                
                //TODO: check Error have logic - Expire, Timeout, -> need to recall again
                switch error.status {
                case .timeout:
                    
                    STRSessionManager.shared.errorHandler.onServerTimeout(api: self).done { (retry) in
                        if retry == true {
                            self.executeAgain().done{ res in
                                seal.fulfill(res)
                                }.catch{error in
                                    seal.reject(error)
                            }
                        }
                        }.catch { (error) in
                            seal.reject(error)
                    }
                default:
                    STRSessionManager.shared.errorHandler.onNetworkError(error: error)
                }
                
                //TODO: Find more error?
                //STRSessionManager.shared.delegate.showError(error: error)
            }
        }
    }
    
    private func getParameters() -> [String : Any]? {
        
        var parameters = params
        if STRSessionManager.shared.config.shouldEnableToken() {
            parameters = params == nil ? [:] : params
            parameters?[STRSessionManager.shared.config.tokenParameterKey() ?? "token"] = STRSessionManager.shared.delegate.getToken(key: "Token")
        }
        return parameters
    }
}

//MARK: Mock Handler
extension STRService {
    private func mockHandler<T: Mappable>() -> Promise<T> {
        return Promise<T>{ seal in
            seal.reject(STRError(messageCode: .unknown))
        }
    }
    
    private func mockHandler<T: Mappable>() -> Promise<[T]> {
        return Promise<[T]>{ seal in
            seal.reject(STRError(messageCode: .unknown))
        }
    }
}
