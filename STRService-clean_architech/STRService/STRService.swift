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
}

public extension STRService {
    
    func execute<T: Mappable>(onSuccess: @escaping (T) -> Void,
                                     onError: @escaping (Error) -> Void) {
        let requestData = RequestData(path: path,
                                      method: method,
                                      params: getParameters(),
                                      headers: headers)
        STRSessionManager.shared.callService(requestData: requestData) { (response: DataResponse<T>) in
            self.responseHandler(response: response, onSuccess: { (dic) in
                onSuccess(dic)
            }, onError: { (error) in
                if let STRError = error as? STRError,
                    STRError == .refreshTokenExpire {
                    //TODO: - refresh token here
                } else {
                    onError(error)
                }
            })
        }
    }
    
    func execute<T: Mappable>(onSuccess: @escaping ([T]) -> Void,
                                     onError: @escaping (Error) -> Void) {
        
        let requestData = RequestData(path: path,
                                      method: method,
                                      params: getParameters(),
                                      headers: headers)
        
        STRSessionManager.shared.callService(requestData: requestData) { (response: DataResponse<[T]>) in
            self.responseHandler(response: response, onSuccess: { (dic) in
                onSuccess(dic)
            }, onError: { (error) in
                if let STRError = error as? STRError,
                    STRError == .refreshTokenExpire {
                    //TODO: - refresh token here
                } else {
                    onError(error)
                }
            })
        }
    }
    
    func responseHandler<T: Mappable>(response: DataResponse<T>, onSuccess: @escaping(T) -> Void, onError:@escaping(Error) -> Void) {
        guard let statusCode = response.response?.statusCode else {
            onError(STRError.noResponse)
            return
        }
        
        if statusCode == 200 {
            guard let data = response.result.value else {
                onError(STRError.noData)
                return
            }
            
            onSuccess(data)
        } else {
            responseHandlerError(statusCode: statusCode) { (error) in
                onError(error)
            }
        }
    }
    
    func responseHandler<T: Mappable>(response: DataResponse<[T]>, onSuccess: @escaping([T]) -> Void, onError:@escaping(Error) -> Void) {
        guard let statusCode = response.response?.statusCode else {
            onError(STRError.noResponse)
            return
        }
        
        if statusCode == 200 {
            guard let data = response.result.value else {
                onError(STRError.noData)
                return
            }
            
            onSuccess(data)
        } else {
            responseHandlerError(statusCode: statusCode) { (error) in
                onError(error)
            }
        }
    }
    
    func responseHandlerError(statusCode: Int, onError: @escaping (Error) -> Void) {
        
        switch statusCode {
            
        case 400: // Bad Request
            STRSessionManager.shared.delegate.showError(error: STRError.badRequest)
            onError(STRError.badRequest)
            
        case 401: //Unauthorized
            STRSessionManager.shared.delegate.showError(error: STRError.unauthorized)
            onError(STRError.unauthorized)
            
        case 403: //Forbidden
            STRSessionManager.shared.delegate.showError(error: STRError.forbidden)
            onError(STRError.forbidden)
            
        case 404: //Not Found
            STRSessionManager.shared.delegate.showError(error: STRError.notFound)
            onError(STRError.notFound)
            
        case 408: //Request Timeout
            STRSessionManager.shared.delegate.showError(error: STRError.requestTimeout)
            onError(STRError.requestTimeout)
            
        case 500: //Internal Server Error
            STRSessionManager.shared.delegate.showError(error: STRError.internalServerError)
            onError(STRError.internalServerError)
            
        case 502: //Bad Gateway
            STRSessionManager.shared.delegate.showError(error: STRError.badGateway)
            onError(STRError.badGateway)
            
        case 504: //Gateway Timeout
            STRSessionManager.shared.delegate.showError(error: STRError.gatewayTimeout)
            onError(STRError.gatewayTimeout)
            
            
        case STRSessionManager.shared.config.tokenStatusCodeExpire(): break //Token expire
//            if STRSessionManager.shared.config.shouldEnableToken() {
//                refreshToken(onSuccess: { data in
//                    onError(STRError.refreshTokenExpire)
//                }) { error in
//                    onError(error)
//                }
//            } else {
//                onError(STRError.tokenExpire)
//            }
            
        default:
            onError(STRError.unknown)
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

extension STRService {
    
    func getParameters() -> [String : Any]? {
        
        var parameters = params
        if STRSessionManager.shared.config.shouldEnableToken() {
            parameters = params == nil ? [:] : params
            parameters?[STRSessionManager.shared.config.tokenParameterKey() ?? "token"] = STRSessionManager.shared.delegate.getToken(key: "Token")
        }
        return parameters
    }
}
