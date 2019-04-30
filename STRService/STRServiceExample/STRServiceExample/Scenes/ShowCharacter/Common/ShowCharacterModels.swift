//
//  ShowCharacterModels.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/19/19.
//

enum ShowCharacterModels {
    
    struct FetchRequest {
        let name: String
    }
    
    struct Response {
        let character: Character
    }
    
    struct ViewModel {
        let name: String
        let description: String
    }
}
