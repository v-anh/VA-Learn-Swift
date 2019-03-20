//
//  ShowCharacterInteractor.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/19/19.
//

struct ShowCharacterInteractor {
    private let presenter: ShowCharacterPresentable
    private let characterWorker: CharacterWorkerType
    
    init(presenter: ShowCharacterPresentable, characterWorker: CharacterWorkerType) {
        self.presenter = presenter
        self.characterWorker = characterWorker
    }
}

extension ShowCharacterInteractor: ShowCharacterBusinessLogic {
    
    func fetchCharacter(with request: ShowCharacterModels.FetchRequest) {
        characterWorker.fetch(name: request.name) { result in
            guard let value = result.value, result.isSuccess else {
                return self.presenter.presentFetchedCharacter(error: result.error ?? .unknownReason(nil))
            }
            
            self.presenter.presentFetchedCharacter(
                for: ShowCharacterModels.Response(character: value)
            )
        }
    }
}
