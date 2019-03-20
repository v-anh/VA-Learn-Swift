//
//  CharactersStoreInterfaces.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/18/19.
//

protocol CharactersStore {
    func fetch(completion: @escaping (Result<[Character], DataError>) -> Void)
}

protocol CharactersWorkerType: CharactersStore {
    
}

protocol CharacterStore {
    func fetch(name: String, completion: @escaping (Result<Character, DataError>) -> Void)
}

protocol CharacterWorkerType: CharacterStore {
    
}
