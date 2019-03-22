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
        service.execute(onSuccess: { (result : Character) in
            completion(.success(result))
        }) { (error) in
            completion(.failure(.nonExistent))
        }
    }
}
