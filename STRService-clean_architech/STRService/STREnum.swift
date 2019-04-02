//
//  STREnum.swift
//  STRService
//
//  Created by Ngo Chi Hai on 3/28/19.
//  Copyright © 2019 Quyen Nguyen The. All rights reserved.
//

import Foundation
import Alamofire

public enum StatusCode:Int {
    case success = 200
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case timeout = 408
    case internalServerError = 500
    case badGateway = 502
    case gatewayTimeout = 504
    case unknown = 999
    case noConnection = -1
    
    
    @available(*, deprecated, message: "Need to create function to create the Error")
    func toError() -> STRError? {
        switch self {
        case .success:
            return nil
        case .badRequest:
            return .badRequest
        case .unauthorized:
            return .unauthorized
        case .forbidden:
            return .forbidden
        case .notFound:
            return .notFound
        case .timeout:
            return .requestTimeout
        case .internalServerError:
            return .internalServerError
        case .badGateway:
            return .badGateway
        case .gatewayTimeout:
            return .gatewayTimeout
        case .unknown:
            return .unknown
        case .noConnection:
            return .noConnection
        }
    }
}
@available(*, deprecated, message: "Using Struct & more detail instead")
public enum STRError: Error {
    case noConnection
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
    
    case unknown
}


public struct STRError1:Error {
    public var status : StatusCode
    public var messageCode:String
    public var messageDesc:String
    public var displayText:String
    public var request:STRService
    public var responseBody:Data
    
}

public enum APIMethod {
    case GET
    case POST
    
    var key:HTTPMethod{
        switch self {
        case .GET:
            return HTTPMethod.get
        case .POST:
            return HTTPMethod.post
        }
    }
}
