//
//  CharacterWorker.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/19/19.
//

import STRService

struct CharacterWorker: CharacterWorkerType {
    private let service: CharacterService
    
    init(service: CharacterService) {
        self.service = service
    }
}

extension CharacterWorker {
    
    func fetch(name: String, completion: @escaping (Result<Character, DataError>) -> Void) {
        service.execute().done { (result : Character) in
            completion(.success(result))
        }.catch { (error) in
            completion(.failure(.nonExistent))
        }
    }
}
