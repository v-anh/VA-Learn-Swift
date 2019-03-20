//
//  CharacterService.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/19/19.
//

import ObjectMapper
import STRService

struct Character: Mappable {
    var name: String = ""
    var description: String = ""
    
    public init?(map: Map) {
    }
    
    mutating public func mapping(map: Map) {
        name         <- map["name"]
        description    <- map["description"]
    }
}

class CharacterService: STRService {
    typealias ResponseType = Character
    
    var data : RequestData {
        return RequestData(path: "https://test.com/character", method: .get, params: [:], headers: nil)
    }
    
    init(){}
}