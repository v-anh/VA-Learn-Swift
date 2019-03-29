import Foundation
import Alamofire
import ObjectMapper

public struct RequestData {
    let path: String
    let method: APIMethod
    let params: [String:Any]?
    let headers: [String: String]?
}

protocol STRAPI {
    var path: String { get }
    var method: APIMethod { get }
    var params: [String: Any]? { get }
    var headers: [String: String]? { get }
    
    func execute<T: Mappable>(onSuccess: @escaping (T) -> Void, onError: @escaping (Error) -> Void)
    func execute<T: Mappable>(onSuccess: @escaping ([T]) -> Void, onError: @escaping (Error) -> Void)
}


