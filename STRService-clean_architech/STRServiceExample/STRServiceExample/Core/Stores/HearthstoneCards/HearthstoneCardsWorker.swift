//
//  HearthstoneCardWorker.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/26/19.
//

import Foundation
import STRService

struct HearthstoneCardsWorker: HearthstoneCardsWorkerType {
    private let service: ListHearthstoneCardsService
    
    init(service: ListHearthstoneCardsService) {
        self.service = service
    }
}

extension HearthstoneCardsWorker {
    
    func fetch(completion: @escaping (Result<[HearthstoneCard], DataError>) -> Void) {
        service.execute(onSuccess: { (result : [HearthstoneCard]) in
            completion(.success(result))
        }) { (error) in
            completion(.failure(.nonExistent))
        }
    }
}
