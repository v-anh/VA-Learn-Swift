//
//  ListHearthstoneCardsInterfaces.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/26/19.
//

protocol ListHearthstoneCardsDisplayable: class, AppDisplayable { // View Controller
    func displayFetchedHearthstoneCards(with viewModel: ListHearthstoneCardsModels.ViewModel)
}

protocol ListHearthstoneCardsBusinessLogic { // Interactor
    func fetchHearthstoneCards(with request: ListHearthstoneCardsModels.FetchRequest)
}

protocol ListHearthstoneCardsPresentable { // Presenter
    func presentFetchedHearthstoneCards(for response: ListHearthstoneCardsModels.Response)
    func presentFetchedHearthstoneCards(error: DataError)
}

protocol ListHearthstoneCardsRoutable: AppRoutable { // Router
    func showHearthstoneCardWith(name: String)
}
