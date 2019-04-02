import Foundation
import Alamofire
import ObjectMapper
import PromiseKit

public struct RequestData {
    let path: String
    let method: APIMethod
    let params: [String:Any]?
    let headers: [String: String]?
}

protocol STRAPI {
    
    
    
    /// The URL for Request
    var path: String { get }
    
    /// Method for REST API - POST, GET, PUT, DELETE, UPDATE
    var method: APIMethod { get }
    
    /// Customized Parameter for the Request
    var params: [String: Any]? { get }
    
    /// Customize Header
    var headers: [String: String]? { get }
    
    
    
    /**
     # The execute function to make the call to the REST API
     ## This execute funtion will return single object when it sucessfull call the API - If you need to return the Array format instead, using this :
     ````execute<T: Mappable>(onSuccess: @escaping ([T]) -> Void, onError: @escaping (Error) -> Void)````
     - Parameters:
        - shouldMock:
        - onSuccess:
            - Return the successfull data object after make the call
        - onError:
            - Return the error data object after make the call
            @@ Description: aawdawd
     **/
    func execute<T: Mappable>(shouldMock:Bool,onSuccess: @escaping (T) -> Void, onError: @escaping  (Error) -> Void)
    
    
    
    /**
     # The execute function to make the call to the REST API
     ## This execute funtion will return aray of object when it sucessfull call the API
     - Parameters:
     - onSuccess:
     - Return the successfull data object after make the call
     - onError:
     - Return the error data object after make the call
     @@ Description: aawdawd
     **/
    func execute<T: Mappable>(shouldMock:Bool,onSuccess: @escaping ([T]) -> Void, onError: @escaping (Error) -> Void)
    
    
    
    func execute<T: Mappable>(shouldMock:Bool) -> Promise<T>
}


