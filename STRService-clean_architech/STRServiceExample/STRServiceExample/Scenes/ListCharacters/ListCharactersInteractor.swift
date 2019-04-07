//
//  ListCharactersInteractor.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/18/19.
//

import Foundation

struct ListCharactersInteractor {
    private let presenter: ListCharactersPresentable
    private let charactersWorker: CharactersWorkerType
    
    init(presenter: ListCharactersPresentable, charactersWorker: CharactersWorkerType) {
        self.presenter = presenter
        self.charactersWorker = charactersWorker
    }
}

extension ListCharactersInteractor: ListCharactersBusinessLogic {
    
    func fetchCharacters(with request: ListCharactersModels.FetchRequest) {
        charactersWorker.fetch { result in
            guard let value = result.value, result.isSuccess else {
                return self.presenter.presentFetchedCharacters(error: result.error ?? .unknownReason(nil))
            }
            
            self.presenter.presentFetchedCharacters(
                for: ListCharactersModels.Response(characters: value)
            )
        }
    }
}
