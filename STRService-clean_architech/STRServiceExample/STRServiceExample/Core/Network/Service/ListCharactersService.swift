//
//  ListCharactersService.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/18/19.
//

import ObjectMapper
import STRService

struct ListCharacters: Mappable {
    var characters: [Character]? = nil

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        characters         <- map["characters"]
    }
}

class ListCharactersService: STRService {
    typealias ResponseType = ListCharacters
    
    var data : RequestData {
        return RequestData(path: "https://test.com/listCharacters", method: .get, params: [:], headers: nil)
    }
    
    init(){}
}


