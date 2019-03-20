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
        service.data = RequestData(path: service.data.path + name.replacingOccurrences(of: " ", with: "")) //Hard code for test
        service.execute(onSuccess: { (result) in
            completion(.success(result))
        }) { (error) in
            completion(.failure(.nonExistent))
        }
    }
}
