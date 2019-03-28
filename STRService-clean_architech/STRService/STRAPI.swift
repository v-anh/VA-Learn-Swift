import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

public struct RequestData {
    let path: String
    let method: HTTPMethod
    let params: [String:Any]?
    let headers: [String: String]?
}

protocol STRAPI {
    var path: String { get }
    var method: HTTPMethod { get }
    var params: [String: Any]? { get }
    var headers: [String: String]? { get }
    
    func execute<T: Mappable>(onSuccess: @escaping (T) -> Void, onError: @escaping (Error) -> Void)
    func execute<T: Mappable>(onSuccess: @escaping ([T]) -> Void, onError: @escaping (Error) -> Void)
}

struct URLSessionNetworkDispatcher<T: Mappable> {
    
    func dispatch(requestData: RequestData, onSuccess: @escaping (T) -> Void, onError: @escaping (Error) -> Void) {
        
        STRNetworkManager.shared.networkManager?.request(requestData.path, method: requestData.method, parameters: requestData.params, encoding: JSONEncoding.default, headers: requestData.headers).responseObject { (response: DataResponse<T>) in
            self.responseHandler(response: response, onSuccess: { (dic) in
                onSuccess(dic)
            }, onError: { (error) in
                if let STRError = error as? STRError, STRError == .refreshTokenExpire {
                    self.dispatch(requestData: requestData, onSuccess: onSuccess, onError: onError)
                } else {
                    onError(error)
                }
            })
        }
    }
    
    func dispatch(requestData: RequestData, onSuccess: @escaping ([T]) -> Void, onError: @escaping (Error) -> Void) {
        
        STRNetworkManager.shared.networkManager?.request(requestData.path, method: requestData.method, parameters: requestData.params, encoding: JSONEncoding.default, headers: requestData.headers).responseArray { (response: DataResponse<[T]>) in
            self.responseHandler(response: response, onSuccess: { (dic) in
                onSuccess(dic)
            }, onError: { (error) in
                if let STRError = error as? STRError, STRError == .refreshTokenExpire {
                    self.dispatch(requestData: requestData, onSuccess: onSuccess, onError: onError)
                } else {
                    onError(error)
                }
            })
        }
    }
}

extension URLSessionNetworkDispatcher {
    
    func responseHandler(response: DataResponse<T>, onSuccess: @escaping(T) -> Void, onError:@escaping(Error) -> Void) {
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
    
    func responseHandler(response: DataResponse<[T]>, onSuccess: @escaping([T]) -> Void, onError:@escaping(Error) -> Void) {
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
            STRCore.getViewable().showError(error: STRError.badRequest)
            onError(STRError.badRequest)
            
        case 401: //Unauthorized
            STRCore.getViewable().showError(error: STRError.unauthorized)
            onError(STRError.unauthorized)
            
        case 403: //Forbidden
            STRCore.getViewable().showError(error: STRError.forbidden)
            onError(STRError.forbidden)
            
        case 404: //Not Found
            STRCore.getViewable().showError(error: STRError.notFound)
            onError(STRError.notFound)
            
        case 408: //Request Timeout
            STRCore.getViewable().showError(error: STRError.requestTimeout)
            onError(STRError.requestTimeout)
            
        case 500: //Internal Server Error
            STRCore.getViewable().showError(error: STRError.internalServerError)
            onError(STRError.internalServerError)
            
        case 502: //Bad Gateway
            STRCore.getViewable().showError(error: STRError.badGateway)
            onError(STRError.badGateway)
            
        case 504: //Gateway Timeout
            STRCore.getViewable().showError(error: STRError.gatewayTimeout)
            onError(STRError.gatewayTimeout)
            
            
        case STRCore.getConfig().refreshTokenConfig?.tokenStatusCodeExpire: //Token expire
            if STRCore.getConfig().enableToken {
                refreshToken(onSuccess: { data in
                    onError(STRError.refreshTokenExpire)
                }) { error in
                    onError(error)
                }
            } else {
                onError(STRError.tokenExpire)
            }
            
        default:
            onError(STRError.unknown)
        }
    }
    
    func refreshToken(onSuccess: @escaping (Any) -> Void, onError: @escaping (Error) -> Void) {
        guard let loopTime = STRCore.getConfig().refreshTokenConfig?.loopTime,
            UserDefaults.getLoopValue() < loopTime else {
                onError(STRError.refreshTokenError)
                return
        }
        UserDefaults.setLoopValue(value: UserDefaults.getLoopValue() + 1)
        
        guard let requestData = STRCore.getConfig().refreshTokenConfig?.requestTokenData else {
            onError(STRError.noRefreshTokenData)
            return
        }
        
        var parameters = requestData.params
        parameters?[STRCore.getConfig().refreshTokenConfig?.tokenParameterKey ?? "token"] = UserDefaults.getToken()
        
        STRNetworkManager.shared.networkManager?.request(requestData.path, method: requestData.method, parameters: parameters, encoding: JSONEncoding.default, headers: requestData.headers).responseObject { (response: DataResponse<T>) in
            
            self.responseHandler(response: response, onSuccess: { (dic) in
                if let dicData = dic as? [String: Any], let token = dicData["token"] as? String {
                    UserDefaults.setToken(token: token)
                }
                onSuccess(dic)
            }, onError: { (error) in
                self.refreshToken(onSuccess: onSuccess, onError: onError)
            })
        }
    }
}

