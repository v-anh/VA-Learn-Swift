//
//  ListHearthstoneCardsPresenter.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/26/19.
//

import Foundation

struct ListHearthstoneCardsPresenter: ListHearthstoneCardsPresentable {
    private weak var viewController: ListHearthstoneCardsDisplayable?
    
    init(viewController: ListHearthstoneCardsDisplayable?) {
        self.viewController = viewController
    }
}

extension ListHearthstoneCardsPresenter {
    
    func presentFetchedHearthstoneCards(for response: ListHearthstoneCardsModels.Response) {
        let viewModel = ListHearthstoneCardsModels.ViewModel(
            hearthstoneCards: response.hearthstoneCards.map { make(card: $0) }
        )
        
        viewController?.displayFetchedHearthstoneCards(with: viewModel)
    }
    
    func presentFetchedHearthstoneCards(error: DataError) {
        // Handle and parse error
        let viewModel = AppModels.Error(
            title: "Characters Error", // TODO: Localize
            message: "There was an error retrieving the characters: \(error)" // TODO: Localize
        )
        
        viewController?.display(error: viewModel)
    }
}

private extension ListHearthstoneCardsPresenter {
    
    func make(card: HearthstoneCard) -> ListHearthstoneCardsModels.HearthstoneCardViewModel {
        return ListHearthstoneCardsModels.HearthstoneCardViewModel(
            name: "Card Name: \(card.name)",
            cardSet: "Card Set: \(card.cardSet)"
        )
    }
}
