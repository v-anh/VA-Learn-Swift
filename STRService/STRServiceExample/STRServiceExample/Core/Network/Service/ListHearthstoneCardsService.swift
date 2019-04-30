//
//  ListHearthstoneCardsService.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/26/19.
//

import STRService

final class ListHearthstoneCardsService: STRService {
    
    override var path: String {
        return "cards/classes/Mage"
    }
    
    override var headers: [String: String]? {
        return ["X-RapidAPI-Key": "AlXj8hIfHbmshz5oW8mZuzrAPXkzp1QeQzcjsntSLI7vjAaA6x"]
    }
}
