//
//  ListCharactersInterfaces.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/18/19.
//

protocol ListCharactersDisplayable: class, AppDisplayable { // View Controller
    func displayFetchedCharacters(with viewModel: ListCharactersModels.ViewModel)
}

protocol ListCharactersBusinessLogic { // Interactor
    func fetchCharacters(with request: ListCharactersModels.FetchRequest)
}

protocol ListCharactersPresentable { // Presenter
    func presentFetchedCharacters(for response: ListCharactersModels.Response)
    func presentFetchedCharacters(error: DataError)
}

protocol ListCharactersRoutable: AppRoutable { // Router
    func showCharacterWith(name: String)
}
