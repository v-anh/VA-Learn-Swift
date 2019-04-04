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
    
    func toError(error: Error) -> STRError? {
        switch self {
        case .success:
            return nil
        case .badRequest:
            return STRError(statusCode: .badRequest, error: error)
        case .unauthorized:
            return STRError(statusCode: .unauthorized, error: error)
        case .forbidden:
            return STRError(statusCode: .forbidden, error: error)
        case .notFound:
            return STRError(statusCode: .notFound, error: error)
        case .timeout:
            return STRError(statusCode: .timeout, error: error)
        case .internalServerError:
            return STRError(statusCode: .internalServerError, error: error)
        case .badGateway:
            return STRError(statusCode: .badGateway, error: error)
        case .gatewayTimeout:
            return STRError(statusCode: .gatewayTimeout, error: error)
        case .unknown:
            return STRError(statusCode: .unknown, error: error)
        case .noConnection:
            return STRError(statusCode: .noConnection, error: error)
        }
    }
}

public enum STRMessageCode: Error {
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

public struct STRError:Error {
    public var status : StatusCode
    public var messageCode:String
    public var messageDesc:String
    public var displayText:String
    public var request:STRService
    public var responseBody: Data?
    
    public init(statusCode: StatusCode = .unknown, error: Error? = nil) {
        self.status = statusCode
        self.messageCode = (error != nil) ? "NETWORK_ERROR" : ""
        self.messageDesc = (error != nil) ? error!.localizedDescription : ""
        self.displayText = (error != nil) ? error!.localizedDescription : ""
        self.request = STRService()
    }
    
    public init(messageCode: STRMessageCode = .unknown, error: Error? = nil) {
        self.status = .unknown
        self.messageCode = messageCode.localizedDescription
        self.messageDesc = (error != nil) ? error!.localizedDescription : ""
        self.displayText = (error != nil) ? error!.localizedDescription : ""
        self.request = STRService()
    }
    
    public init(statusCode: StatusCode = .unknown,
                messageCode: String = "",
                messageDesc: String = "",
                displayText: String = "",
                request: STRService = STRService(),
                responseBody: Data? = nil) {
        self.status = statusCode
        self.messageCode = messageCode
        self.messageDesc = messageDesc
        self.displayText = displayText
        self.request = request
        self.responseBody = responseBody
    }
}

public enum APIMethod {
    case GET
    case POST
    
    var key: HTTPMethod {
        switch self {
        case .GET:
            return HTTPMethod.get
        case .POST:
            return HTTPMethod.post
        }
    }
}
