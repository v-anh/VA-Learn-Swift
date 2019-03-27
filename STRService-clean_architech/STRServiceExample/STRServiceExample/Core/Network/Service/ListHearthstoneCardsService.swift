//
//  ListHearthstoneCardsService.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/26/19.
//

import STRService

public class ListHearthstoneCardsService: STRService {
    
    public var data : RequestData {
        return RequestData(path: "https://omgvamp-hearthstone-v1.p.rapidapi.com/cards/classes/Mage", method: .get, params: nil, headers: ["X-RapidAPI-Key": "AlXj8hIfHbmshz5oW8mZuzrAPXkzp1QeQzcjsntSLI7vjAaA6x"])
    }
    
    init(){}
}
