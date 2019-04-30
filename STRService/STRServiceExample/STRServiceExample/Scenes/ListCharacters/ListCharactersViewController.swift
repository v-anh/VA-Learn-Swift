//
//  ListCharactersViewController.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/15/19.
//

import UIKit

class ListCharactersViewController: UIViewController, HasDependencies {
    
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
        charactersWorker: dependencies.resolveWorker())
    
    private lazy var router: ListCharactersRoutable = ListCharactersRouter(
        viewController: self
    )
    
    // View Model
    private var viewModel: ListCharactersModels.ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

