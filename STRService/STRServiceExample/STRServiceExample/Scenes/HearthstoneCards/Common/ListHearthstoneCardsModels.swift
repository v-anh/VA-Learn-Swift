//
//  ListHearthstoneCardsModels.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/26/19.
//

enum ListHearthstoneCardsModels {
    
    struct FetchRequest {
        
    }
    
    struct Response {
        let hearthstoneCards: [HearthstoneCard]
    }
    
    struct ViewModel {
        let hearthstoneCards: [HearthstoneCardViewModel]
    }
    
    struct HearthstoneCardViewModel {
        let name: String
        let cardSet: String
    }
}
