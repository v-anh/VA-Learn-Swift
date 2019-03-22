//
//  CharacterType.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/18/19.
//
import ObjectMapper

public struct Character: Mappable {
    var name: String = ""
    var description: String = ""
    
    public init?(map: Map) {
    }
    
    mutating public func mapping(map: Map) {
        name         <- map["name"]
        description    <- map["description"]
    }
}

public struct ListCharacters: Mappable {
    var characters: [Character]? = nil
    
    public init?(map: Map) {
    }
    
    mutating public func mapping(map: Map) {
        characters         <- map["characters"]
    }
}
