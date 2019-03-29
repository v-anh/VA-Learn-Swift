//
//  STREnum.swift
//  STRService
//
//  Created by Ngo Chi Hai on 3/28/19.
//  Copyright © 2019 Quyen Nguyen The. All rights reserved.
//

import Foundation
import Alamofire

public enum STRError: Error {
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
