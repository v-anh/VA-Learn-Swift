//
//  ListCharactersService.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/18/19.
//

import ObjectMapper
import STRService

public struct ListCharacters: Mappable {
    var characters: [Character]? = nil

    public init?(map: Map) {
    }

    mutating public func mapping(map: Map) {
        characters         <- map["characters"]
    }
}

public class ListCharactersService: STRService {
    
    public var data : RequestData {
        return RequestData(path: "https://test.com/listCharacters", method: .get, params: [:], headers: nil)
    }
    
    init(){}
}


