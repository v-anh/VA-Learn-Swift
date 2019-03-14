//
//  ProfileService.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/4/19.
//  Copyright © 2019 Quyen Nguyen The. All rights reserved.
//

import ObjectMapper
import STRService

struct Profile: Mappable {
    var fullname: String = ""
    var avatar: String = ""
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        fullname    <- map["fullname"]
        avatar    <- map["avatar"]
    }
}

class ProfileService: STRService {
    typealias ResponseType = Profile
    
    var data : RequestData {
        return RequestData(path: "https://test.com/profile")
    }
    
    init(){}
}
