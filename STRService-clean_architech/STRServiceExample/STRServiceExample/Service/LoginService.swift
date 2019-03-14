//
//  LoginService.swift
//  STRService
//
//  Created by Quyen Nguyen The on 2/22/19.
//  Copyright © 2019 Quyen Nguyen The. All rights reserved.
//

import ObjectMapper
import STRService

public struct User: Mappable {
    var id: Int = -1
    var username: String = ""
    var token: String = ""
    
    public init?(map: Map) {
    }
    
    mutating public func mapping(map: Map) {
        id         <- map["id"]
        username    <- map["username"]
        token <- map["token"]
    }
}

public class LoginService: STRService {
    public typealias ResponseType = User
    
    public var data : RequestData {
        return RequestData(path: "https://test.com/login", method: .get, params: [:], headers: nil)
    }
    
    public init(){}
}

