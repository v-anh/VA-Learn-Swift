//
//  ListHearthstoneCardsInteractor.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/26/19.
//

import Foundation

struct ListHearthstoneCardsInteractor {
    private let presenter: ListHearthstoneCardsPresentable
    private let hearthstoneCardsWorker: HearthstoneCardsWorkerType
    
    init(presenter: ListHearthstoneCardsPresentable, hearthstoneCardsWorker: HearthstoneCardsWorkerType) {
        self.presenter = presenter
        self.hearthstoneCardsWorker = hearthstoneCardsWorker
    }
}

extension ListHearthstoneCardsInteractor: ListHearthstoneCardsBusinessLogic {
    
    func fetchHearthstoneCards(with request: ListHearthstoneCardsModels.FetchRequest) {
        
//        let service = ListHearthstoneCardsService()
//            .set(handlerErrorManually: true)
//            .set(handlerErrorCompletion: { (error) in
//                //Manual show error advoid default error
//                
//            })
//        
//        service.execute(onSuccess: { (result : [HearthstoneCard]) in
//            
//            
//        }) { (error) in
//            
//            
//        }
        
        hearthstoneCardsWorker.fetch { result in
            guard let value = result.value, result.isSuccess else {
                return self.presenter.presentFetchedHearthstoneCards(error: result.error ?? .unknownReason(nil))
            }
            
            self.presenter.presentFetchedHearthstoneCards(
                for: ListHearthstoneCardsModels.Response(hearthstoneCards: value)
            )
        }
    }
}