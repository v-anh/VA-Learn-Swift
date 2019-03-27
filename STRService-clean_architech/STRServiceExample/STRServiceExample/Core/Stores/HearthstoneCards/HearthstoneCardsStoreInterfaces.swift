//
//  HearthstoneCardsStoreInterfaces.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/26/19.
//

import Foundation

public protocol HearthstoneCardsStore {
    func fetch(completion: @escaping (Result<[HearthstoneCard], DataError>) -> Void)
}

public protocol HearthstoneCardsWorkerType: HearthstoneCardsStore {
    
}
