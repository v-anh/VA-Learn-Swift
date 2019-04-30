//
//  ShowCharacterViewController.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/19/19.
//

import UIKit
import OHHTTPStubs

class ShowCharacterViewController: UIViewController, HasDependencies {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descriptions: UILabel!
    
    private lazy var interactor: ShowCharacterBusinessLogic = ShowCharacterInteractor(presenter: ShowCharacterPresenter(viewController: self), characterWorker: dependencies.resolveWorker())
    
    private lazy var router: ShowCharacterRoutable = ShowCharacterRouter(
        viewController: self
    )
    
    convenience init(interactor: ShowCharacterBusinessLogic, router: ShowCharacterRoutable) {
        self.init()
        self.interactor = interactor
        self.router = router
    }
    
    // View Model
    private var viewModel: ShowCharacterModels.ViewModel?
    
    var characterName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }

    func loadData() {
        interactor.fetchCharacter(with: ShowCharacterModels.FetchRequest(name: characterName))
    }
}

extension ShowCharacterViewController: ShowCharacterDisplayable {
    
    func displayFetchedCharacter(with viewModel: ShowCharacterModels.ViewModel) {
        name.text = viewModel.name
        descriptions.text = viewModel.description
    }
}
