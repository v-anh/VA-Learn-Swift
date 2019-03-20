//
//  ShowCharacterViewController.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/19/19.
//

import UIKit
import OHHTTPStubs

class ShowCharacterViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descriptions: UILabel!
    
    private lazy var interactor: ShowCharacterBusinessLogic = ShowCharacterInteractor(
        presenter: ShowCharacterPresenter(viewController: self),
        characterWorker: CharacterWorker(service: CharacterService())
    )
    
    private lazy var router: ListCharactersRoutable = ListCharactersRouter(
        viewController: self
    )
    
    // View Model
    private var viewModel: ListCharactersModels.ViewModel?
    
    var characterName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupOHHTTPStubForTest()
        loadData()
    }

    func loadData() {
        interactor.fetchCharacter(
            with: ShowCharacterModels.FetchRequest(
                name: characterName
            )
        )
    }
}

extension ShowCharacterViewController: ShowCharacterDisplayable {
    
    func displayFetchedCharacter(with viewModel: ShowCharacterModels.ViewModel) {
        name.text = viewModel.name
        descriptions.text = viewModel.description
    }
}

extension ShowCharacterViewController {
    func setupOHHTTPStubForTest() {
        stub(condition: isPath("/character") ) { _ in
            return OHHTTPStubsResponse(
                jsonObject: [
                    "name": "Barbarian",
                    "description": "Brute force makes a successful return, the Barbarian devastates foes with mighty power."
                ],
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
    }
}
