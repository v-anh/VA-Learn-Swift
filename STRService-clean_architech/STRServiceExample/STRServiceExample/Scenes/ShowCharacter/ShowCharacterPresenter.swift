//
//  ShowCharacterPresenter.swift
//  
//
//  Created by Ngo Chi Hai on 3/19/19.
//

struct ShowCharacterPresenter: ShowCharacterPresentable {
    private weak var viewController: ShowCharacterDisplayable?
    
    init(viewController: ShowCharacterDisplayable?) {
        self.viewController = viewController
    }
}

extension ShowCharacterPresenter {
    
    func presentFetchedCharacter(for response: ShowCharacterModels.Response) {
        let viewModel = ShowCharacterModels.ViewModel(
            name: response.character.name,
            description: response.character.description
        )
        
        viewController?.displayFetchedCharacter(with: viewModel)
    }
    
    func presentFetchedCharacter(error: DataError) {
        // Handle and parse error
        let viewModel = AppModels.Error(
            title: "Character Error", // TODO: Localize
            message: "There was an error retrieving the character: \(error)" // TODO: Localize
        )
        
        viewController?.display(error: viewModel)
    }
}
