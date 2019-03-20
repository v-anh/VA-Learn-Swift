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
    associatedtype ResponseType: Mappable
    var data: RequestData { get }
}
//public protocol NetworkDispatcher {
//    func dispatch(requestData: RequestData, onSuccess: @escaping (Any) -> Void, onError: @escaping (Error) -> Void)
//}
public struct URLSessionNetworkDispatcher<T: Mappable> {
    
//    public static let instance = URLSessionNetworkDispatcher()
    
    public init() {}
    
    public func dispatch(requestData: RequestData, onSuccess: @escaping (T) -> Void, onError: @escaping (Error) -> Void) {
        var parameters = requestData.params
        
        if STRConfig.shared.config?.enableToken ?? false {
            parameters?[STRConfig.shared.config?.refreshTokenConfig?.tokenParameterKey ?? "token"] = UserDefaults.getToken()
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
    
    
    func responseHandler(response:DataResponse<T>, onSuccess: @escaping(T) -> Void, onError:@escaping(Error) -> Void) {
        guard let statusCode = response.response?.statusCode else {
            onError(ConnError.noResponse)
            return
        }
        
        switch statusCode {
        case 200:
            guard let data = response.result.value else {
                onError(ConnError.noData)
                return
            }
            
            onSuccess(data)
            
        case 400: // Bad Request
            STRConfig.shared.viewable?.showError(error: ConnError.badRequest)
        
        case 401: //Unauthorized
            STRConfig.shared.viewable?.showError(error: ConnError.unauthorized)
        
        case 403: //Forbidden
            STRConfig.shared.viewable?.showError(error: ConnError.forbidden)
            
        case 404: //Not Found
            STRConfig.shared.viewable?.showError(error: ConnError.notFound)
            
        case 408: //Request Timeout
            STRConfig.shared.viewable?.showError(error: ConnError.requestTimeout)
            
        case 500: //Internal Server Error
            STRConfig.shared.viewable?.showError(error: ConnError.internalServerError)
            
        case 502: //Bad Gateway
            STRConfig.shared.viewable?.showError(error: ConnError.badGateway)
            
        case 504: //Gateway Timeout
            STRConfig.shared.viewable?.showError(error: ConnError.gatewayTimeout)
        
        
        case STRConfig.shared.config?.refreshTokenConfig?.tokenStatusCodeExpire: //Token expire
            if STRConfig.shared.config?.enableToken ?? false {
                refreshToken(onSuccess: { data in
                    onError(ConnError.refreshTokenExpire)
                }) { error in
                    onError(error)
                }
            } else {
                onError(ConnError.tokenExpire)
            }
            
        default:
            if let error = response.error {
                onError(error)
                return
            }
        }
    }
    
    func refreshToken(onSuccess: @escaping (Any) -> Void, onError: @escaping (Error) -> Void) {
        guard let loopTime = STRConfig.shared.config?.refreshTokenConfig?.loopTime,
            UserDefaults.getLoopValue() < loopTime else {
                onError(ConnError.refreshTokenError)
                return
        }
        UserDefaults.setLoopValue(value: UserDefaults.getLoopValue() + 1)
        
        guard let requestData = STRConfig.shared.config?.refreshTokenConfig?.requestTokenData else {
            onError(ConnError.noRefreshTokenData)
            return
        }
        
        var parameters = requestData.params
        parameters?[STRConfig.shared.config?.refreshTokenConfig?.tokenParameterKey ?? "token"] = UserDefaults.getToken()
        
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
    
    public func execute(dispatcher: URLSessionNetworkDispatcher<ResponseType> = URLSessionNetworkDispatcher<ResponseType>(),
                        onSuccess: @escaping (ResponseType) -> Void,
                        onError: @escaping (Error) -> Void) {
        
        dispatcher.dispatch(requestData: self.data, onSuccess: { (data) in
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


