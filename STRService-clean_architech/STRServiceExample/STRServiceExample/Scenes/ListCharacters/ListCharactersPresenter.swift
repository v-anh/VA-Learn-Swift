//
//  ListCharactersPresenter.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/18/19.
//

struct ListCharactersPresenter: ListCharactersPresentable {
    private weak var viewController: ListCharactersDisplayable?
    
    init(viewController: ListCharactersDisplayable?) {
        self.viewController = viewController
    }
}

extension ListCharactersPresenter {
    
    func presentFetchedCharacters(for response: ListCharactersModels.Response) {
        let viewModel = ListCharactersModels.ViewModel(
            characters: response.characters.map { make(character: $0) }
        )
        
        viewController?.displayFetchedCharacters(with: viewModel)
    }
    
    func presentFetchedCharacters(error: DataError) {
        // Handle and parse error
        let viewModel = AppModels.Error(
            title: "Characters Error", // TODO: Localize
            message: "There was an error retrieving the characters: \(error)" // TODO: Localize
        )
        
        viewController?.display(error: viewModel)
    }
}

private extension ListCharactersPresenter {
    
    func make(character: Character) -> ListCharactersModels.CharacterViewModel {
        return ListCharactersModels.CharacterViewModel(
            name: character.name,
            description: "Infomation: \(character.description)"
        )
    }
}
