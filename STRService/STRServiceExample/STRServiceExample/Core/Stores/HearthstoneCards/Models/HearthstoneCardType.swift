//
//  HearthstoneCardType.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/26/19.
//

import ObjectMapper

public struct HearthstoneCard: Mappable {
    var name: String = ""
    var cardSet: String = ""
    
    public init?(map: Map) {
    }
    
    mutating public func mapping(map: Map) {
        name         <- map["name"]
        cardSet    <- map["cardSet"]
    }
}

public struct ListHearthstoneCards: Mappable {
    var cardsClassic: [HearthstoneCard]? = nil
    
    public init?(map: Map) {
    }
    
    mutating public func mapping(map: Map) {
        cardsClassic         <- map["Classic"]
    }
}
