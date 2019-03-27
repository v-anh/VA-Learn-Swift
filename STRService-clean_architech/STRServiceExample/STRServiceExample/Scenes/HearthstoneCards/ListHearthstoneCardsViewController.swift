//
//  ListHearthstoneCardsViewController.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/22/19.
//

import UIKit
import Alamofire

class ListHearthstoneCardsViewController: UIViewController, HasDependencies {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(
                UINib(nibName: String(describing: HearthstoneCardViewCell.self), bundle: nil),
                forCellReuseIdentifier: String(describing: HearthstoneCardViewCell.self)
            )
        }
    }
    
    private lazy var interactor: ListHearthstoneCardsBusinessLogic = ListHearthstoneCardsInteractor(
        presenter: ListHearthstoneCardsPresenter(viewController: self),
        hearthstoneCardsWorker: dependencies.resolveWorker())
    
    private lazy var router: ListHearthstoneCardsRoutable = ListHearthstoneCardsRouter(
        viewController: self
    )
    
    // View Model
    private var viewModel: ListHearthstoneCardsModels.ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        loadData()
//        Alamofire.request("https://omgvamp-hearthstone-v1.p.rapidapi.com/cards?cost=10", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X-RapidAPI-Key":"AlXj8hIfHbmshz5oW8mZuzrAPXkzp1QeQzcjsntSLI7vjAaA6x"]).responseJSON { (data) in
//            print(data.result.value)
//        }
    }

    func loadData() {
        interactor.fetchHearthstoneCards(with: ListHearthstoneCardsModels.FetchRequest())
    }
    
    func loadUI() {
        tableView.reloadData()
    }
}

extension ListHearthstoneCardsViewController: ListHearthstoneCardsDisplayable {
    
    func displayFetchedHearthstoneCards(with viewModel: ListHearthstoneCardsModels.ViewModel) {
        self.viewModel = viewModel
        loadUI()
    }
}

extension ListHearthstoneCardsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = viewModel?.hearthstoneCards[indexPath.row] else { return }
        router.showHearthstoneCardWith(name: model.name)
    }
}

extension ListHearthstoneCardsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.hearthstoneCards.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HearthstoneCardViewCell.self), for: indexPath) as! HearthstoneCardViewCell
        
        guard let model = viewModel?.hearthstoneCards[indexPath.row] else { return cell }
        cell.bind(model)
        
        return cell
    }
}
