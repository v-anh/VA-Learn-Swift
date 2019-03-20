//
//  CharactersWorker.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/18/19.
//
import STRService

struct CharactersWorker: CharactersWorkerType {
    private let service: ListCharactersService
    
    init(service: ListCharactersService) {
        self.service = service
    }
}

extension CharactersWorker {
    
    func fetch(completion: @escaping (Result<[Character], DataError>) -> Void) {
        service.execute(onSuccess: { (result) in
            guard let characters = result.characters else {
                completion(.failure(.nonExistent))
                return
            }
            completion(.success(characters))
        }) { (error) in
            completion(.failure(.nonExistent))
        }
    }
}
