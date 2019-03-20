//
//  ShowCharacterViewController.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/19/19.
//

import UIKit
import OHHTTPStubs

class ShowCharacterViewController: UIViewController,HasDependencies {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descriptions: UILabel!
    
    private lazy var interactor: ShowCharacterBusinessLogic = ShowCharacterInteractor(presenter: ShowCharacterPresenter(viewController: self), characterWorker: dependencies.resolveWorker())
    
    private lazy var router: ShowCharacterRoutable = ShowCharacterRouter(
        viewController: self
    )
    
    // View Model
    private var viewModel: ShowCharacterModels.ViewModel?
    
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
        stub(condition: isPath("/characterBarbarian") ) { _ in
            return OHHTTPStubsResponse(
                jsonObject: [
                    "name": "Barbarian",
                    "description": "Brute force makes a successful return, the Barbarian devastates foes with mighty power."
                ],
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
        
        stub(condition: isPath("/characterWitchDoctor") ) { _ in
            return OHHTTPStubsResponse(
                jsonObject: [
                    "name": "Witch Doctor",
                    "description": "Deemed the successor of the Necromancer. The Witch Doctor uses death, disease, curses and undead minions to swarm his would be opponents and drain their health and inflict impeding statuses on them."
                ],
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
        
        stub(condition: isPath("/characterWizard") ) { _ in
            return OHHTTPStubsResponse(
                jsonObject: [
                    "name": "Wizard",
                    "description": "Manipulating the primal forces of the storm, arcane and even time itself, the Wizard is not afraid to destroy all in the path to victory. Successor of the Sorceress and Sorcerer."
                ],
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
        
        stub(condition: isPath("/characterMonk") ) { _ in
            return OHHTTPStubsResponse(
                jsonObject: [
                    "name": "Monk",
                    "description": "A religious warrior of the light, they are masters of the martial arts and speed."
                ],
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
        
        stub(condition: isPath("/characterDemonHunter") ) { _ in
            return OHHTTPStubsResponse(
                jsonObject: [
                    "name": "Demon Hunter",
                    "description": "A stealthy warrior, specializes in crossbows and launching explosives with a focus mainly on ranged combat."
                ],
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
        
        stub(condition: isPath("/characterCrusader") ) { _ in
            return OHHTTPStubsResponse(
                jsonObject: [
                    "name": "Crusader",
                    "description": "A middle-ranged melee class with a combat style centered around shields, flails, and spells (introduced in Reaper of Souls)"
                ],
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
        
        stub(condition: isPath("/characterNecromancer") ) { _ in
            return OHHTTPStubsResponse(
                jsonObject: [
                    "name": "Necromancer",
                    "description": "A re-imagining of the class from Diablo II, available with the Rise of the Necromancer pack."
                ],
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
    }
}
