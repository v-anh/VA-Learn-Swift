import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

public enum ConnError: Swift.Error {
    case invalidURL
    case noData
    case dataError
    case noResponse
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case requestTimeout
    case gatewayTimeout
    case badGateway
    case internalServerError
    
    case noRefreshTokenData
    case refreshTokenError
    case tokenExpire
    case refreshTokenExpire
    
    case unknown
}

public struct RequestData {
    public let path: String
    public let method: HTTPMethod
    public var params: [String:Any]?
    public let headers: [String: String]?
    
    public init(path: String,
         method: HTTPMethod = .get,
         params: [String: Any]? = nil,
         headers: [String: String]? = nil) {
        self.path = path
        self.method = method
        self.params = params
        self.headers = headers
    }
}

public protocol STRService {
    var data: RequestData { get }
}

public struct URLSessionNetworkDispatcher<T: Mappable> {

    public init() {}
    
    public func dispatch(requestData: RequestData, onSuccess: @escaping (T) -> Void, onError: @escaping (Error) -> Void) {
        var parameters = requestData.params
        
        if STRCore.getConfig().enableToken {
            parameters?[STRCore.getConfig().refreshTokenConfig?.tokenParameterKey ?? "token"] = STRCore.getViewable().getToken(key: "Token")
        }
        
        STRNetworkManager.shared.networkManager?.request(requestData.path, method: requestData.method, parameters: parameters, encoding: JSONEncoding.default, headers: requestData.headers).responseObject { (response: DataResponse<T>) in
            self.responseHandler(response: response, onSuccess: { (dic) in
                onSuccess(dic)
            }, onError: { (error) in
                if let connError = error as? ConnError, connError == .refreshTokenExpire {
                    self.dispatch(requestData: requestData, onSuccess: onSuccess, onError: onError)
                } else {
                    onError(error)
                }
            })
        }
    }
    
    public func dispatchWithArrayResponse(requestData: RequestData, onSuccess: @escaping ([T]) -> Void, onError: @escaping (Error) -> Void) {
        var parameters = requestData.params
        
        if STRCore.getConfig().enableToken {
            parameters?[STRCore.getConfig().refreshTokenConfig?.tokenParameterKey ?? "token"] = STRCore.getViewable().getToken(key: "Token")
        }
        
        STRNetworkManager.shared.networkManager?.request(requestData.path, method: requestData.method, parameters: parameters, encoding: JSONEncoding.default, headers: requestData.headers).responseArray { (response: DataResponse<[T]>) in
            self.responseArrayHandler(response: response, onSuccess: { (dic) in
                onSuccess(dic)
            }, onError: { (error) in
                if let connError = error as? ConnError, connError == .refreshTokenExpire {
                    self.dispatchWithArrayResponse(requestData: requestData, onSuccess: onSuccess, onError: onError)
                } else {
                    onError(error)
                }
            })
        }
    }
    
    
    func responseHandler(response:DataResponse<T>, onSuccess: @escaping(T) -> Void, onError:@escaping(Error) -> Void) {
        guard let statusCode = response.response?.statusCode else {
            onError(ConnError.noResponse)
            return
        }
        
        if statusCode == 200 {
            guard let data = response.result.value else {
                onError(ConnError.noData)
                return
            }
            
            onSuccess(data)
        } else {
            responseHandlerError(statusCode: statusCode) { (error) in
                onError(error)
            }
        }
    }
    
    func responseArrayHandler(response:DataResponse<[T]>, onSuccess: @escaping([T]) -> Void, onError:@escaping(Error) -> Void) {
        guard let statusCode = response.response?.statusCode else {
            onError(ConnError.noResponse)
            return
        }
        
        if statusCode == 200 {
            guard let data = response.result.value else {
                onError(ConnError.noData)
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
            STRCore.getViewable().showError(error: ConnError.badRequest)
            onError(ConnError.badRequest)
            
        case 401: //Unauthorized
            STRCore.getViewable().showError(error: ConnError.unauthorized)
            onError(ConnError.unauthorized)
            
        case 403: //Forbidden
            STRCore.getViewable().showError(error: ConnError.forbidden)
            onError(ConnError.forbidden)
            
        case 404: //Not Found
            STRCore.getViewable().showError(error: ConnError.notFound)
            onError(ConnError.notFound)
            
        case 408: //Request Timeout
            STRCore.getViewable().showError(error: ConnError.requestTimeout)
            onError(ConnError.requestTimeout)
            
        case 500: //Internal Server Error
            STRCore.getViewable().showError(error: ConnError.internalServerError)
            onError(ConnError.internalServerError)
            
        case 502: //Bad Gateway
            STRCore.getViewable().showError(error: ConnError.badGateway)
            onError(ConnError.badGateway)
            
        case 504: //Gateway Timeout
            STRCore.getViewable().showError(error: ConnError.gatewayTimeout)
            onError(ConnError.gatewayTimeout)
            
            
        case STRCore.getConfig().refreshTokenConfig?.tokenStatusCodeExpire: //Token expire
            if STRCore.getConfig().enableToken {
                refreshToken(onSuccess: { data in
                    onError(ConnError.refreshTokenExpire)
                }) { error in
                    onError(error)
                }
            } else {
                onError(ConnError.tokenExpire)
            }
            
        default:
            onError(ConnError.unknown)
        }
    }
    
    func refreshToken(onSuccess: @escaping (Any) -> Void, onError: @escaping (Error) -> Void) {
        guard let loopTime = STRCore.getConfig().refreshTokenConfig?.loopTime,
            UserDefaults.getLoopValue() < loopTime else {
                onError(ConnError.refreshTokenError)
                return
        }
        UserDefaults.setLoopValue(value: UserDefaults.getLoopValue() + 1)
        
        guard let requestData = STRCore.getConfig().refreshTokenConfig?.requestTokenData else {
            onError(ConnError.noRefreshTokenData)
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

public extension STRService {
    
    public func execute<T: Mappable>(onSuccess: @escaping (T) -> Void,
                                     onError: @escaping (Error) -> Void) {
        URLSessionNetworkDispatcher<T>().dispatch(requestData: self.data, onSuccess: { (data) in
            UserDefaults.setLoopValue(value: 0)
            onSuccess(data)
        }) { (error) in
            UserDefaults.setLoopValue(value: 0)
            DispatchQueue.main.async {
                onError(error)
            }
        }
    }
    
    public func executeWithArrayResponse<T: Mappable>(onSuccess: @escaping ([T]) -> Void,
                                     onError: @escaping (Error) -> Void) {
        URLSessionNetworkDispatcher<T>().dispatchWithArrayResponse(requestData: self.data, onSuccess: { (data) in
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


