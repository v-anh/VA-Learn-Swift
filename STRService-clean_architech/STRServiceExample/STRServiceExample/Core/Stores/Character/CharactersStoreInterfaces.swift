//
//  CharactersStoreInterfaces.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/18/19.
//

public protocol CharactersStore {
    func fetch(completion: @escaping (Result<[Character], DataError>) -> Void)
}

public protocol CharactersWorkerType: CharactersStore {
    
}

public protocol CharacterStore {
    func fetch(name: String, completion: @escaping (Result<Character, DataError>) -> Void)
}

public protocol CharacterWorkerType: CharacterStore {
    
}
