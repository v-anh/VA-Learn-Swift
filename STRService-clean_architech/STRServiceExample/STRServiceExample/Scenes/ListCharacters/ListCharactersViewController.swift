//
//  ListCharactersViewController.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/15/19.
//

import UIKit
import OHHTTPStubs

class ListCharactersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(
                UINib(nibName: String(describing: ListItemViewCell.self), bundle: nil),
                forCellReuseIdentifier: String(describing: ListItemViewCell.self)
            )
        }
    }
    
    private lazy var interactor: ListCharactersBusinessLogic = ListCharactersInteractor(
        presenter: ListCharactersPresenter(viewController: self),
        charactersWorker: CharactersWorker(service: ListCharactersService())
    )
    
    private lazy var router: ListCharactersRoutable = ListCharactersRouter(
        viewController: self
    )
    
    // View Model
    private var viewModel: ListCharactersModels.ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupOHHTTPStubForTest()
        loadData()
    }
    
    func loadData() {
        interactor.fetchCharacters(with: ListCharactersModels.FetchRequest())
    }
    
    func loadUI() {
        tableView.reloadData()
    }
}

extension ListCharactersViewController: ListCharactersDisplayable {
    
    func displayFetchedCharacters(with viewModel: ListCharactersModels.ViewModel) {
        self.viewModel = viewModel
        loadUI()
    }
}

extension ListCharactersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = viewModel?.characters[indexPath.row] else { return }
        router.showCharacterWith(name: model.name)
    }
}

extension ListCharactersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.characters.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ListItemViewCell.self), for: indexPath) as! ListItemViewCell
        
        guard let model = viewModel?.characters[indexPath.row] else { return cell }
        cell.bind(model)
        
        return cell
    }
}

extension ListCharactersViewController {
    func setupOHHTTPStubForTest() {
        stub(condition: isPath("/listCharacters") ) { _ in
            return OHHTTPStubsResponse(
                jsonObject: [
                    "characters": [
                        [
                            "name": "Barbarian",
                            "description": "Brute force makes a successful return, the Barbarian devastates foes with mighty power."
                        ],[
                            "name": "Witch Doctor",
                            "description": "Deemed the successor of the Necromancer. The Witch Doctor uses death, disease, curses and undead minions to swarm his would be opponents and drain their health and inflict impeding statuses on them."
                        ],[
                            "name": "Wizard",
                            "description": "Manipulating the primal forces of the storm, arcane and even time itself, the Wizard is not afraid to destroy all in the path to victory. Successor of the Sorceress and Sorcerer."
                        ],[
                            "name": "Monk",
                            "description": "A religious warrior of the light, they are masters of the martial arts and speed."
                        ],[
                            "name": "Demon Hunter",
                            "description": "A stealthy warrior, specializes in crossbows and launching explosives with a focus mainly on ranged combat."
                        ],[
                            "name": "Crusader",
                            "description": "A middle-ranged melee class with a combat style centered around shields, flails, and spells (introduced in Reaper of Souls)"
                        ],[
                            "name": "Necromancer",
                            "description": "A re-imagining of the class from Diablo II, available with the Rise of the Necromancer pack."
                        ]
                    ]
                ],
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
    }
}
