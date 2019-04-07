//
//  ShowCharacterInterfaces.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/19/19.
//

protocol ShowCharacterDisplayable: class, AppDisplayable {
    func displayFetchedCharacter(with viewModel: ShowCharacterModels.ViewModel)
}

protocol ShowCharacterBusinessLogic {
    func fetchCharacter(with request: ShowCharacterModels.FetchRequest)
}

protocol ShowCharacterPresentable {
    func presentFetchedCharacter(for response: ShowCharacterModels.Response)
    func presentFetchedCharacter(error: DataError)
}

protocol ShowCharacterRoutable: AppRoutable {
    
}
