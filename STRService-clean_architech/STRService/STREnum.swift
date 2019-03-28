//
//  STREnum.swift
//  STRService
//
//  Created by Ngo Chi Hai on 3/28/19.
//  Copyright © 2019 Quyen Nguyen The. All rights reserved.
//

import Foundation

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
