//
//  ListCharactersModels.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/18/19.
//

enum ListCharactersModels {
    
    struct FetchRequest {

    }
    
    struct Response {
        let characters: [Character]
    }
    
    struct ViewModel {
        let characters: [CharacterViewModel]
    }
    
    struct CharacterViewModel {
        let name: String
        let description: String
    }
}
